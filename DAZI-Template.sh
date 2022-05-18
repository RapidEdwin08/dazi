#!/bin/bash
# https://github.com/RapidEdwin08/dazi

# INPUT D00M.WAD + M0D.WAD/PK3/PK7/ZIPs
doomWAD=~/RetroPie/roms/ports/doom/doom.wad
doomM0D=~/RetroPie/roms/ports/doom/mods/SIGIL.zip
doomM0D2=~/RetroPie/roms/ports/doom/mods/weapons_of_saturn.pk3
doomM0D3=~/RetroPie/roms/ports/doom/mods/WOSHUD.pk3
doomM0D4=
doomM0D5=

# Define addonDIR - Default RetroPie or DAZI tmpfs
addonDIR=/dev/shm/addon
#addonDIR=~/RetroPie/roms/ports/doom/addon

# UNCOMMENT to Display Loading Files by name
#echo LOADING $(basename "$doomM0D" ) $(basename "$doomM0D2" ) $(basename "$doomM0D3" ) $(basename "$doomM0D4" ) $(basename "$doomM0D5" )

# Prepare addonDIR + M0Ds in Numeric 0rder
mkdir "$addonDIR" > /dev/null 2>&1
if [ ! "$doomM0D" == "" ]; then if [[ "$doomM0D" == *".zip" ]] || [[ "$doomM0D" == *".ZIP" ]]; then unzip -qq -o "$doomM0D" -d "$addonDIR" > /dev/null 2>&1; else ln -s "$doomM0D" "$addonDIR/01_$(basename "$doomM0D" )"; fi; fi > /dev/null 2>&1
if [ ! "$doomM0D2" == "" ]; then if [[ "$doomM0D2" == *".zip" ]] || [[ "$doomM0D2" == *".ZIP" ]]; then unzip -qq -o "$doomM0D2" -d "$addonDIR" > /dev/null 2>&1; else ln -s "$doomM0D2" "$addonDIR/02_$(basename "$doomM0D2" )"; fi; fi > /dev/null 2>&1
if [ ! "$doomM0D3" == "" ]; then if [[ "$doomM0D3" == *".zip" ]] || [[ "$doomM0D3" == *".ZIP" ]]; then unzip -qq -o "$doomM0D3" -d "$addonDIR" > /dev/null 2>&1; else ln -s "$doomM0D3" "$addonDIR/03_$(basename "$doomM0D3" )"; fi; fi > /dev/null 2>&1
if [ ! "$doomM0D4" == "" ]; then if [[ "$doomM0D4" == *".zip" ]] || [[ "$doomM0D4" == *".ZIP" ]]; then unzip -qq -o "$doomM0D4" -d "$addonDIR" > /dev/null 2>&1; else ln -s "$doomM0D4" "$addonDIR/04_$(basename "$doomM0D4" )"; fi; fi > /dev/null 2>&1
if [ ! "$doomM0D5" == "" ]; then if [[ "$doomM0D5" == *".zip" ]] || [[ "$doomM0D5" == *".ZIP" ]]; then unzip -qq -o "$doomM0D5" -d "$addonDIR" > /dev/null 2>&1; else ln -s "$doomM0D5" "$addonDIR/05_$(basename "$doomM0D5" )"; fi; fi > /dev/null 2>&1

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"

# CASE#1: [runcommand.log] FILLED = ROM was Launched/Played -> DELETE the [addonDIR]
# CASE#2: [runcommand.log] BLANK = EXIT WITHOUT LAUNCHING -> KEEP the [addonDIR]
# USE CASE#2 to Pre-Load a M0D in [addonDIR] BY SELECTING [EXIT WITHOUT LAUNCHING]
if [ ! "$(cat /dev/shm/runcommand.log)" == "" ]; then rm "$addonDIR" -R -f && mkdir "$addonDIR" > /dev/null 2>&1; fi
