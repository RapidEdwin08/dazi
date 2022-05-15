#!/bin/bash
# https://github.com/RapidEdwin08/dazi

# INPUT D00M.WAD + D00M-M0D.ZIPs
doomWAD=~/RetroPie/roms/ports/doom/doom2.wad
modZIP=~/RetroPie/roms/ports/doom/mods/BrutalDoom.zip
optionalZIP=~/RetroPie/roms/ports/doom/mods/HellOnEarthStarterPack.zip

# Define addonDIR - Default RetroPie or Default DAZI tmpfs
#addonDIR=~/RetroPie/roms/ports/doom/addon
addonDIR=/dev/shm/addon

# Display Loading Files by name
echo LOADING $(echo "$modZIP" | sed 's|.*/||' ) $(echo "$optionalZIP" | sed 's|.*/||' )

# Extract D00M-M0D.zip + 0ptional-D00M-M0D.zip into addonDIR If Defined
mkdir "$addonDIR" > /dev/null 2>&1
if [ ! "$modZIP" == "" ]; then unzip -qq -o $modZIP -d $addonDIR > /dev/null 2>&1; fi
if [ ! "$optionalZIP" == "" ]; then unzip -qq -o $optionalZIP -d $addonDIR > /dev/null 2>&1; fi

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"

# CASE#1: [runcommand.log] FILLED = ROM was Launched/Played -> DELETE the [addonDIR]
# CASE#2: [runcommand.log] BLANK = EXIT WITHOUT LAUNCHING -> KEEP the [addonDIR]
# USE CASE#2 to Pre-Load a M0D in [addonDIR] BY SELECTING [EXIT WITHOUT LAUNCHING]
if [ ! "$(cat /dev/shm/runcommand.log)" == "" ]; then rm "$addonDIR" -R -f && mkdir "$addonDIR" > /dev/null 2>&1; fi
