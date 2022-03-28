#!/bin/bash

# INPUT D00M.WAD + D00M-M0D.ZIPs
doomWAD=~/RetroPie/roms/ports/doom/doom2.wad
modZIP=~/RetroPie/roms/ports/doom/mods/BrutalDoom.zip
optionalZIP=~/RetroPie/roms/ports/doom/mods/BrutalDoom_HellOnEarthStarterPack.zip

# Define addonDIR - eg. ~/RetroPie/roms/ports/doom/addon #Default
addonDIR=/dev/shm/addon #tmpfs

# Extract D00M-M0D.zip + 0ptional-D00M-M0D.zip into addonDIR If Defined
mkdir "$addonDIR" > /dev/null 2>&1
if [ ! "$modZIP" == "" ]; then unzip -qq -o $modZIP -d $addonDIR > /dev/null 2>&1; fi
if [ ! "$optionalZIP" == "" ]; then unzip -qq -o $optionalZIP -d $addonDIR > /dev/null 2>&1; fi

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"

# CASE#1: [runcommand.log] FILLED = ROM was Launched/Played -> DELETE the [addonDIR]
# CASE#2: [runcommand.log] BLANK = EXIT WITHOUT LAUNCHING -> KEEP the [addonDIR]
# CASE#2 Allows you to Pre-Load a M0D in [addonDIR] if you SELECT a M0D + EXIT WITHOUT LAUNCHING
if [ ! "$(cat /dev/shm/runcommand.log)" == "" ]; then rm "$addonDIR" -R -f > /dev/null 2>&1; fi
