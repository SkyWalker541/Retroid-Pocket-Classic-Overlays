// SkyWalker_UniversalPixelGrid_PRO.glsl
// Universal fullscreen pixel grid (GLSL, GLES2+)
// Created by: SkyWalker541
// Pick the exact system+resolution with named toggles below.
// If ALL toggles are OFF, the shader uses Custom Native Width/Height.
// Image is tuned for crisp, not-washed-out defaults; grid aligns evenly at fullscreen.
//
// Placement:
//   RetroArch/shaders/shaders_glsl/handheld/shaders/SkyWalker_UniversalPixelGrid_PRO.glsl

#ifdef VERTEX
attribute vec4 VertexCoord;
attribute vec2 TexCoord;
varying vec2 TEX0;
uniform mat4 MVPMatrix;
void main() {
    gl_Position = MVPMatrix * VertexCoord;
    TEX0 = TexCoord;
}
#endif

#ifdef FRAGMENT
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec2 TEX0;
uniform sampler2D Texture;

uniform vec2 OutputSize;
uniform vec2 OriginalSize;
uniform vec2 SourceSize;

// ===== Custom Native Resolution (fallback when all toggles OFF) =====
#pragma parameter P_NATIVE_W      "Custom Native Width (px)"   160.0 0.0 2048.0 1.0
#pragma parameter P_NATIVE_H      "Custom Native Height (px)"  144.0 0.0 2048.0 1.0

// ===== System + Resolution Toggles (set ONE to 1.0) =====
// Game Boy / Game Boy Color
#pragma parameter P_GB_160x144    "GB/GBC 160x144"            1.0 0.0 1.0 1.0

// Game Boy Advance
#pragma parameter P_GBA_240x160   "GBA 240x160"               0.0 0.0 1.0 1.0

// NES (NTSC/PAL common active area)
#pragma parameter P_NES_256x240   "NES 256x240"               0.0 0.0 1.0 1.0

// SNES (common modes)
#pragma parameter P_SNES_256x224  "SNES 256x224"              0.0 0.0 1.0 1.0
#pragma parameter P_SNES_256x239  "SNES 256x239"              0.0 0.0 1.0 1.0
#pragma parameter P_SNES_512x448  "SNES 512x448 (Hi-Res)"     0.0 0.0 1.0 1.0

// Genesis / Mega Drive
#pragma parameter P_GEN_320x224   "Genesis/MD 320x224"        0.0 0.0 1.0 1.0
#pragma parameter P_GEN_256x224   "Genesis/MD 256x224"        0.0 0.0 1.0 1.0

// PlayStation 1 (common modes; interlaced listed for completeness)
#pragma parameter P_PS1_256x240   "PS1 256x240"               0.0 0.0 1.0 1.0
#pragma parameter P_PS1_320x240   "PS1 320x240"               0.0 0.0 1.0 1.0
#pragma parameter P_PS1_368x240   "PS1 368x240"               0.0 0.0 1.0 1.0
#pragma parameter P_PS1_512x240   "PS1 512x240"               0.0 0.0 1.0 1.0
#pragma parameter P_PS1_640x480   "PS1 640x480 (i)"           0.0 0.0 1.0 1.0

// Neo Geo (MVS/AES)
#pragma parameter P_NEO_320x224   "Neo Geo 320x224"           0.0 0.0 1.0 1.0
#pragma parameter P_NEO_304x224   "Neo Geo 304x224 (common crop)" 0.0 0.0 1.0 1.0

// Master System
#pragma parameter P_SMS_256x192   "Master System 256x192"     0.0 0.0 1.0 1.0
#pragma parameter P_SMS_256x224   "Master System 256x224"     0.0 0.0 1.0 1.0

// Neo Geo Pocket
#pragma parameter P_NGP_160x152   "Neo Geo Pocket 160x152"    0.0 0.0 1.0 1.0

// ===== Image Clarity (crisp defaults) =====
#pragma parameter P_SHARP_STRENGTH "Image Sharpness"          0.45 0.0 1.0 0.01
#pragma parameter P_SHARP_RADIUS   "Sharpen Radius"           0.55 0.0 1.5 0.01
#pragma parameter P_DESHIMMER      "Flicker Reduction"        0.10 0.0 1.0 0.01
#pragma parameter P_CONTRAST       "Contrast"                 1.12 0.5 2.0 0.01
#pragma parameter P_SCREEN_LIGHT   "Screen Light"             0.02 0.0 0.5 0.01

// ===== Grid Appearance =====
#pragma parameter P_GRID_OPACITY   "Grid Brightness"          0.32 0.0 1.0 0.01
#pragma parameter P_GRID_WX        "Grid Line Width X (px)"   1.00 0.0 3.0 0.10
#pragma parameter P_GRID_WY        "Grid Line Width Y (px)"   1.00 0.0 3.0 0.10
#pragma parameter P_GRID_AA        "Grid Edge Smooth (px)"    0.40 0.0 2.0 0.05
#pragma parameter P_GRID_R         "Grid Color (R)"           1.00 0.0 1.0 0.01
#pragma parameter P_GRID_G         "Grid Color (G)"           1.00 0.0 1.0 0.01
#pragma parameter P_GRID_B         "Grid Color (B)"           1.00 0.0 1.0 0.01

// ===== Fine Alignment =====
#pragma parameter P_PHASE_X        "Fine Align X (px)"        0.00 -1.0 1.0 0.05
#pragma parameter P_PHASE_Y        "Fine Align Y (px)"        0.00 -1.0 1.0 0.05

// Explicit uniforms
uniform float P_NATIVE_W, P_NATIVE_H;
uniform float P_GB_160x144;
uniform float P_GBA_240x160;
uniform float P_NES_256x240;
uniform float P_SNES_256x224, P_SNES_256x239, P_SNES_512x448;
uniform float P_GEN_320x224, P_GEN_256x224;
uniform float P_PS1_256x240, P_PS1_320x240, P_PS1_368x240, P_PS1_512x240, P_PS1_640x480;
uniform float P_NEO_320x224, P_NEO_304x224;
uniform float P_SMS_256x192, P_SMS_256x224;
uniform float P_NGP_160x152;

uniform float P_SHARP_STRENGTH, P_SHARP_RADIUS, P_DESHIMMER, P_CONTRAST, P_SCREEN_LIGHT;
uniform float P_GRID_OPACITY, P_GRID_WX, P_GRID_WY, P_GRID_AA, P_GRID_R, P_GRID_G, P_GRID_B;
uniform float P_PHASE_X, P_PHASE_Y;

// --- Minimal helpers ---
vec4 deshimmer(vec2 uv, float amt){
    if (amt <= 0.0) return texture2D(Texture, uv);
    vec2 t = 1.0 / SourceSize;
    vec4 base = texture2D(Texture, uv);
    vec4 c  = base * 4.0;
    c += texture2D(Texture, uv + vec2(t.x, 0.0));
    c += texture2D(Texture, uv - vec2(t.x, 0.0));
    c += texture2D(Texture, uv + vec2(0.0, t.y));
    c += texture2D(Texture, uv - vec2(0.0, t.y));
    c /= 8.0;
    return mix(base, c, clamp(amt, 0.0, 1.0));
}
vec4 sharpen(vec2 uv, float strength, float radius){
    if (strength <= 0.0) return texture2D(Texture, uv);
    vec2 t = 1.0 / SourceSize;
    vec4 h = texture2D(Texture, uv + vec2( t.x, 0.0));
    h += texture2D(Texture, uv + vec2(-t.x, 0.0));
    vec4 v = texture2D(Texture, uv + vec2( 0.0, t.y));
    v += texture2D(Texture, uv + vec2( 0.0,-t.y));
    vec4 blur = (h + v + 2.0*texture2D(Texture, uv)) * 0.25;
    vec4 base = texture2D(Texture, uv);
    vec4 detail = base - blur;
    return clamp(base + detail * strength, 0.0, 1.0);
}
float line_mask(float d, float thick, float aa){
    float edge = thick + max(aa, 0.0);
    return 1.0 - smoothstep(thick, edge, d);
}

// Resolve native size from toggles (first ON wins). If none ON, return 0,0.
vec2 nativeFromToggles(){
    if (P_GB_160x144   > 0.5) return vec2(160.0,144.0);
    if (P_GBA_240x160  > 0.5) return vec2(240.0,160.0);
    if (P_NES_256x240  > 0.5) return vec2(256.0,240.0);
    if (P_SNES_256x224 > 0.5) return vec2(256.0,224.0);
    if (P_SNES_256x239 > 0.5) return vec2(256.0,239.0);
    if (P_SNES_512x448 > 0.5) return vec2(512.0,448.0);
    if (P_GEN_320x224  > 0.5) return vec2(320.0,224.0);
    if (P_GEN_256x224  > 0.5) return vec2(256.0,224.0);
    if (P_PS1_256x240  > 0.5) return vec2(256.0,240.0);
    if (P_PS1_320x240  > 0.5) return vec2(320.0,240.0);
    if (P_PS1_368x240  > 0.5) return vec2(368.0,240.0);
    if (P_PS1_512x240  > 0.5) return vec2(512.0,240.0);
    if (P_PS1_640x480  > 0.5) return vec2(640.0,480.0);
    if (P_NEO_320x224  > 0.5) return vec2(320.0,224.0);
    if (P_NEO_304x224  > 0.5) return vec2(304.0,224.0);
    if (P_SMS_256x192  > 0.5) return vec2(256.0,192.0);
    if (P_SMS_256x224  > 0.5) return vec2(256.0,224.0);
    if (P_NGP_160x152  > 0.5) return vec2(160.0,152.0);
    return vec2(0.0);
}

void main(){
    // Image shaping (crisp baseline)
    vec4 img = deshimmer(TEX0, P_DESHIMMER);
    img = mix(img, sharpen(TEX0, P_SHARP_STRENGTH, P_SHARP_RADIUS), 1.0);
    img.rgb = clamp((img.rgb - 0.5) * P_CONTRAST + 0.5, 0.0, 1.0);
    img.rgb = clamp(img.rgb + P_SCREEN_LIGHT, 0.0, 1.0);

    // Determine native size
    vec2 nativeSize = nativeFromToggles();
    if (nativeSize.x <= 0.0 || nativeSize.y <= 0.0){
        nativeSize = (SourceSize.x > 0.0 && SourceSize.y > 0.0) ? SourceSize : OriginalSize;
    }
    if (nativeSize.x <= 0.0 || nativeSize.y <= 0.0){
        if (P_NATIVE_W > 0.0 && P_NATIVE_H > 0.0) nativeSize = vec2(P_NATIVE_W, P_NATIVE_H);
    }

    // Grid aligned to emulated pixels at fullscreen
    vec2 sp   = gl_FragCoord.xy - vec2(P_PHASE_X, P_PHASE_Y);
    vec2 cell = OutputSize / max(nativeSize, vec2(1.0));

    float dx = abs(mod(sp.x, cell.x)); dx = min(dx, cell.x - dx);
    float dy = abs(mod(sp.y, cell.y)); dy = min(dy, cell.y - dy);

    float gx = line_mask(dx, P_GRID_WX, P_GRID_AA);
    float gy = line_mask(dy, P_GRID_WY, P_GRID_AA);
    float g  = clamp(max(gx, gy), 0.0, 1.0);

    vec3 grid_color = vec3(P_GRID_R, P_GRID_G, P_GRID_B);
    img.rgb = mix(img.rgb, grid_color, g * P_GRID_OPACITY);

    gl_FragColor = img;
}
#endif
