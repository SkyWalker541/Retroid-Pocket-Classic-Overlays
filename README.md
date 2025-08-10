[SkyWalker541_Universal_Grid_Shader_User_Guide.txt](https://github.com/user-attachments/files/21707597/SkyWalker541_Universal_Grid_Shader_User_Guide.txt)***Update 8/10/2025: I am trying my hand at shaders now. I have uploaded two options. Universal Pixel Grid & Universal Pixel Grid PRO. There are lots of setting for these shaders. Be sure to check them out.***

***Please note, that these shaders are specific to the Retroid Pocket Classic, Ayaneo Pocket DMG, and Retroid Pocket Mini V2***

***Below I have inserted the .txt file contents, with instructions and some of the features:***

SkyWalker541 Universal Grid Shader - User Guide
================================================

Creator: SkyWalker541

Overview
--------
This package contains two shaders:

1. Universal Version
   - One toggle per system (e.g., Game Boy, GBC, NES, etc.).
   - Only ONE system toggle should be ON at a time. Turning on more than one at once can cause grid misalignment or distortion.
   - If all toggles are set to 0 (OFF), the shader will use the Custom Width and Custom Height parameters instead.

2. Universal PRO Version
   - Same as Universal Version, but each system includes additional resolution-specific toggles for variants of that console's native resolution.
   - Again, only ONE toggle should be ON at a time to avoid conflicts.
   - If all toggles are set to 0 (OFF), the shader will use the Custom Width and Custom Height parameters.

Installation
------------
Place files in the following locations:

- GLSLP files:
  RetroArch/shaders/shaders_glsl/

- GLSL files:
  RetroArch/shaders/shaders_glsl/shaders/

Parameter Controls
------------------
1 = Toggle ON (enable preset resolution for that system)
0 = Toggle OFF (disable preset)

If ALL system toggles are OFF, shader defaults to the custom width and height values.

Available Presets (Universal)
-----------------------------
- Game Boy
- Game Boy Color
- NES
- SNES
- Sega Genesis / Mega Drive
- Neo Geo Pocket / Color
- PlayStation 1
- Game Boy Advance
- Sega Saturn
- Custom (when all toggles are OFF)

Additional Presets (Universal PRO)
----------------------------------
Includes everything in Universal version PLUS separate toggles for alternate resolutions for each supported system.

Usage Tips
----------
- Always make sure only ONE preset toggle is ON at a time.
- For custom scaling, turn ALL presets OFF and adjust Custom Width and Height parameters manually.
- Adjust opacity and line thickness to your preference in shader parameters.
Universal_Grid_Shader_User_Guide.txt…]()


***Update 8/2/2025: I have reuploaded DMG, GBC, and GBA Bezels. Sorry it has taken me so long, but I finally got the bezels to be true black for the OLED screens. I have also placed what was previously called "Requested Overlays", as "Custom Bezels" within each systems main folder.***


***If you are new to GitHub, and are trying to download my content: Click the green, "Code" button, and select "Download ZIP"***


***If you need help understanding how overlays work, and how to install them, please take a look at Russ' (RetroGameCorps) guide:***

https://retrogamecorps.com/2024/09/01/guide-shaders-and-overlays-on-retro-handhelds/


***Note: Bezel Fade options add a shadow to the edge on the game screen (This helps re-create the look of an inset screen on older handheld consoles).***


***MAKE SURE TO TURN OFF THE FOLLOWING IN THE "On-Screen Overlay" MENU.***

- "Auto-Scale Overlay" Set this to OFF.
- I also recommend messing with the overlay Opacity. See how you like it.


***Note: These overlays are 100% compatible with the Ayaneo Pocket DMG and the Retroid Pocket Mini V2, as they all use the same screen***


***DMG:***
<img width="1240" height="1080" alt="DMG_1240_bezel_grid_integer_1px_black" src="https://github.com/user-attachments/assets/37dc505e-e8ee-4afa-9d79-1caad5642095" />
Photo: DMG_1240_bezel_grid_integer_1px_black


<img width="1240" height="1080" alt="DMG_1240_bezel_only_integer" src="https://github.com/user-attachments/assets/50cab3d1-5609-423d-ae96-649393599609" />
Photo: DMG_1240_bezel_only_integer


***GBC:***
<img width="1240" height="1080" alt="GBC_1240_bezel_fade_grid_integer_1px_black" src="https://github.com/user-attachments/assets/c3b66085-59dc-4948-a1c7-ee1382e660cb" />
Photo: GBC_1240_bezel_fade_grid_integer_1px_black


<img width="1240" height="1080" alt="GBC_1240_bezel_grid_integer_1px_black" src="https://github.com/user-attachments/assets/93d60061-8128-4623-b7c2-e9065e6f5ca7" />
Photo: GBC_1240_bezel_grid_integer_1px_black


<img width="1240" height="1080" alt="GBC_1240_bezel_only_integer_pokemon" src="https://github.com/user-attachments/assets/6572388d-1bfc-44f1-b7a2-1825ad09520b" />
Photo: GBC_1240_bezel_only_integer_pokemon (Located in: GBC/Custom Bezels)


***GBA:***
<img width="1240" height="1080" alt="GBA_1240_bezel_fade_grid_integer_1px_black" src="https://github.com/user-attachments/assets/6c937986-bedd-4729-b9a0-610e240ffb23" />
Photo: GBA_1240_bezel_fade_grid_integer_1px_black


<img width="1240" height="1080" alt="GBA_1240_bezel_grid_integer_1px_black" src="https://github.com/user-attachments/assets/10abe0ca-f785-4cbf-a116-630e836a1700" />
Photo: GBA_1240_bezel_grid_integer_1px_black


<img width="1240" height="1080" alt="gba_5x_top_aligned_overlay_fade" src="https://github.com/user-attachments/assets/859f122b-2648-42fd-ade8-77b3326994a7" />
Photo: gba_5x_top_aligned_overlay_fade (Locared in: GBA/Custom Bezels/Bezel Fades)


<img width="1240" height="1080" alt="GBA_1240_OGbezel_fade_grid_integer_1px_black" src="https://github.com/user-attachments/assets/78a3a4c1-9819-4c3f-992f-a3d51c894822" />
Photo: GBA_1240_OGbezel_fade_grid_integer_1px_black (Locared in: GBA/Custom Bezels/Bezel Fades)


<img width="1240" height="1080" alt="GBA_Castlevania_Bezel" src="https://github.com/user-attachments/assets/89180cdd-696a-4255-965c-851b1258f404" />
Photo: GBA_Castlevania_Bezel (Located in GBA/Custom Bezels/Castlevania Bezels)


<img width="1240" height="1080" alt="GBA_1240_bezel_only_integer_pikachu" src="https://github.com/user-attachments/assets/dde71344-b344-4288-b844-c92e697438f1" />
Photo: GBA_1240_bezel_only_integer_pikachu (Located in GBA/Custom Bezels/Pokemon Bezels)


<img width="1240" height="1080" alt="gba_5x_top_aligned_overlay_fade_TLOZ" src="https://github.com/user-attachments/assets/23929b36-e32a-4c16-86ae-934b8a369fbf" />
Photo: gba_5x_top_aligned_overlay_fade_TLOZ (Located in GBA/Custom Bezels/Zelda Bezels)


<img width="1240" height="1080" alt="gba_5x_top_aligned_overlay_fade_Kirby" src="https://github.com/user-attachments/assets/dde6e287-cc0d-461f-a0d1-b6b0fd933464" />
Photo: gba_5x_top_aligned_overlay_fade_Kirby (Located in GBA/Custom Bezels/Kirby Bezels)


<img width="1240" height="1080" alt="GBA_Metroid_2" src="https://github.com/user-attachments/assets/0d3da7cb-18d9-4777-9f8e-70cd8f397634" />
Photo: GBA_Metroid_2 (Located in GBA/Custom Bezels/Metroid Bezels)

***PSX:***
<img width="1240" height="1080" alt="PSX" src="https://github.com/user-attachments/assets/5fe78b47-fab7-4ca6-a65a-76866f660038" />
Photo: PSX

