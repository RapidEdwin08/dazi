#!/bin/bash
# https://github.com/RapidEdwin08/dazi  #v2022.12

# Define [D00M.WAD] - /full/path/to/doom.wad
doomWAD=~/RetroPie/roms/ports/doom/doom2.wad

# 0ptional Define As Many [doomMOD#s] As Needed Starting with #1 - Ascending Numeric 0rder
doomMOD1=~/RetroPie/roms/ports/doom/mods/MAPs/WhispersOfSatan/WOS.7z
doomMOD2=~/RetroPie/roms/ports/doom/mods/PWADs/SuperDoom/Super_Doom_v1-4-0_FIXED.pk3
doomMOD3=~/RetroPie/roms/ports/doom/mods/HUDs/WOSHUD.pk3
doomMOD4=~/RetroPie/roms/ports/doom/mods/0ther/pistolstart.pk3

# 0ptional WARP and DIFFICULTY Settings - Leave episodeNUM= *BLANK* For Doom II MAPs - eg. Doom II MAP31 Nightmare! -> episodeNUM= mapNUM=31 skillLEVEL=5
episodeNUM=
mapNUM=33
skillLEVEL=3

# Define addonDIR  -  /dev/shm/addon  -  ~/RetroPie/roms/ports/doom/addon  -  /opt/retropie/configs/ports/prboom-plus/autoload/doom-all
addonDIR=/dev/shm/addon

# DAZI=M0D=LOADER - Update doomWAD[-warp] IF WARP Settings are DEFINED
if [ ! "$mapNUM" == "" ]; then doomWAD="${addonDIR%/*}/$(basename "${doomWAD}" | cut -d. -f1 )-warp.$(basename "${doomWAD}" | sed "s/^.*\.//")"; fi
if [ ! "$addonDIR" == ~/RetroPie/roms/ports/doom/addon ]; then doomWAD="${addonDIR%/*}/$(basename "${doomWAD}" | cut -d. -f1 ).$(basename "${doomWAD}" | sed "s/^.*\.//")"; fi # Update addonDIR/doomWAD
bash /opt/retropie/configs/ports/doom/lzdoom-dazi.sh loadmod "$0" > /dev/null 2>&1 # Load M0Ds with DAZI=M0D=LOADER

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"
