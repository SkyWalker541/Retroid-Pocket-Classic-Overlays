// SkyWalker_UniversalPixelGrid.glsl
// Universal fullscreen pixel grid (GLSL, GLES2+)
// Created by: SkyWalker541
// Pick the system via named toggles below, or set Custom Native Width/Height.
// No numeric preset slider.

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

// ===== Parameters =====
// Custom native resolution (used if no system toggle is set)
#pragma parameter P_NATIVE_W      "Custom Native Width (px)"  160.0 0.0 1024.0 1.0
#pragma parameter P_NATIVE_H      "Custom Native Height (px)" 144.0 0.0 1024.0 1.0

// Named toggles (set ONE to 1.0 to choose)
#pragma parameter P_SYS_GB        "System: Game Boy / GBC"    1.0 0.0 1.0 1.0
#pragma parameter P_SYS_GBA       "System: Game Boy Advance"  0.0 0.0 1.0 1.0
#pragma parameter P_SYS_NES       "System: NES"               0.0 0.0 1.0 1.0
#pragma parameter P_SYS_SNES      "System: SNES"              0.0 0.0 1.0 1.0
#pragma parameter P_SYS_GEN       "System: Genesis / MD"      0.0 0.0 1.0 1.0
#pragma parameter P_SYS_PS1       "System: PlayStation 1"     0.0 0.0 1.0 1.0
#pragma parameter P_SYS_NEO       "System: Neo Geo"           0.0 0.0 1.0 1.0
#pragma parameter P_SYS_SMS       "System: Master System"     0.0 0.0 1.0 1.0
#pragma parameter P_SYS_NGP       "System: Neo Geo Pocket"    0.0 0.0 1.0 1.0

// Image clarity
#pragma parameter P_SHARP_STRENGTH "Image Sharpness"          0.45 0.0 1.0 0.01
#pragma parameter P_SHARP_RADIUS   "Sharpen Radius"           0.55 0.0 1.5 0.01
#pragma parameter P_DESHIMMER      "Flicker Reduction"        0.10 0.0 1.0 0.01
#pragma parameter P_CONTRAST       "Contrast"                 1.12 0.5 2.0 0.01
#pragma parameter P_SCREEN_LIGHT   "Screen Light"             0.02 0.0 0.5 0.01

// Grid appearance
#pragma parameter P_GRID_OPACITY   "Grid Brightness"          0.32 0.0 1.0 0.01
#pragma parameter P_GRID_WX        "Grid Line Width X (px)"   1.00 0.0 3.0 0.10
#pragma parameter P_GRID_WY        "Grid Line Width Y (px)"   1.00 0.0 3.0 0.10
#pragma parameter P_GRID_AA        "Grid Edge Smooth (px)"    0.40 0.0 2.0 0.05
#pragma parameter P_GRID_R         "Grid Color (R)"           1.00 0.0 1.0 0.01
#pragma parameter P_GRID_G         "Grid Color (G)"           1.00 0.0 1.0 0.01
#pragma parameter P_GRID_B         "Grid Color (B)"           1.00 0.0 1.0 0.01

// Fine alignment
#pragma parameter P_PHASE_X        "Fine Align X (px)"        0.00 -1.0 1.0 0.05
#pragma parameter P_PHASE_Y        "Fine Align Y (px)"        0.00 -1.0 1.0 0.05

// Explicit uniforms
uniform float P_NATIVE_W;
uniform float P_NATIVE_H;

uniform float P_SYS_GB;
uniform float P_SYS_GBA;
uniform float P_SYS_NES;
uniform float P_SYS_SNES;
uniform float P_SYS_GEN;
uniform float P_SYS_PS1;
uniform float P_SYS_NEO;
uniform float P_SYS_SMS;
uniform float P_SYS_NGP;

uniform float P_SHARP_STRENGTH;
uniform float P_SHARP_RADIUS;
uniform float P_DESHIMMER;
uniform float P_CONTRAST;
uniform float P_SCREEN_LIGHT;
uniform float P_GRID_OPACITY;
uniform float P_GRID_WX;
uniform float P_GRID_WY;
uniform float P_GRID_AA;
uniform float P_GRID_R;
uniform float P_GRID_G;
uniform float P_GRID_B;
uniform float P_PHASE_X;
uniform float P_PHASE_Y;

vec2 nativeFromToggles(){
    if (P_SYS_GB  > 0.5) return vec2(160.0,144.0);
    if (P_SYS_GBA > 0.5) return vec2(240.0,160.0);
    if (P_SYS_NES > 0.5) return vec2(256.0,240.0);
    if (P_SYS_SNES> 0.5) return vec2(256.0,224.0);
    if (P_SYS_GEN > 0.5) return vec2(320.0,224.0);
    if (P_SYS_PS1 > 0.5) return vec2(320.0,240.0);
    if (P_SYS_NEO > 0.5) return vec2(320.0,224.0);
    if (P_SYS_SMS > 0.5) return vec2(256.0,192.0);
    if (P_SYS_NGP > 0.5) return vec2(160.0,152.0);
    return vec2(0.0);
}

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

void main(){
    // Image shaping
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

    // Grid
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
