#!/bin/bash
# https://github.com/RapidEdwin08/dazi  #v2022.05

# Define [D00M.WAD] -  /full/path/to/doom.wad
doomWAD=~/RetroPie/roms/ports/doom/doom.wad

# Define As Many [doomMOD#s] As Needed - Ascending Numeric 0rder - [doomMOD#=/full/path/to/mod.pk3]
doomMOD1=~/RetroPie/roms/ports/doom/mods/SIGIL.zip
doomMOD2=~/RetroPie/roms/ports/doom/mods/WeaponsOfSaturn/weapons_of_saturn.pk3
doomMOD3=~/RetroPie/roms/ports/doom/mods/WOSHUD.pk3
doomMOD4=~/RetroPie/roms/ports/doom/mods/DooM_-_Double_Jump.pk3

# Define addonDIR - tmpfs or Default RetroPie
addonDIR=/dev/shm/addon
#addonDIR=~/RetroPie/roms/ports/doom/addon

# ==========================================
loadM0Ds() # Scripted L00P Supports Loading Any Number of [doomMOD#s] when Defined
{
# Prepare [doomMOD#s] IF DEFINED - ZIPs are Extracted to [addonDIR] - Symbolic LInks created for ALL 0THER File Types
if [[ ! "${!rollingM0D}" == "" ]]; then if [[ "${!rollingM0D}" == *".zip" ]] || [[ "${!rollingM0D}" == *".ZIP" ]]; then unzip -qq -o "${!rollingM0D}" -d "$addonDIR" > /dev/null 2>&1; else ln -s "${!rollingM0D}" "$addonDIR/0${count}_$(basename "${!rollingM0D}" )"; fi; fi > /dev/null 2>&1
count=$(( $count + 1 )) # Increase count by+1
rollingM0D="doomMOD${count}" # Apply Increased count to [doomMOD#]
if [[ ! "${!rollingM0D}" == "" ]]; then loadM0Ds; fi # Prepare more [doomMOD#s] IF DEFINED
}

mkdir "$addonDIR" > /dev/null 2>&1 # Prepare addonDIR
count=1 # Set Initial Count
rollingM0D="doomMOD${count}"
loadM0Ds # Load D00M M0Ds in Numeric 0rder

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"

# CASE#1: [runcommand.log] FILLED = ROM was Launched/Played -> DELETE the [addonDIR]
# CASE#2: [runcommand.log] BLANK = EXIT WITHOUT LAUNCHING -> KEEP the [addonDIR]
# USE CASE#2 to Pre-Load a M0D in [addonDIR] BY SELECTING [EXIT WITHOUT LAUNCHING]
if [ ! "$(cat /dev/shm/runcommand.log)" == "" ]; then rm "$addonDIR" -R -f && mkdir "$addonDIR" > /dev/null 2>&1; fi
