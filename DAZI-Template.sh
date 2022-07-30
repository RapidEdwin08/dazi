# https://github.com/RapidEdwin08/dazi  #v2022.08

# Define [D00M.WAD] - /full/path/to/doom.wad
doomWAD=~/RetroPie/roms/ports/doom/doomu.wad

# 0ptional Define As Many [doomMOD#s] As Needed Starting with #1 - Ascending Numeric 0rder
doomMOD1=~/RetroPie/roms/ports/doom/mods/SIGIL.zip
doomMOD2=~/RetroPie/roms/ports/doom/mods/Modifiers/WeaponsOfSaturn/weapons_of_saturn.pk3
doomMOD3=~/RetroPie/roms/ports/doom/mods/HUDs/WOSHUD.pk3
doomMOD4=~/RetroPie/roms/ports/doom/mods/0ther/DooM_-_Double_Jump.pk3

# 0ptional WARP and DIFFICULTY Settings For [lzdoom-dazi+warp] - eg. Ultimate Doom SIGIL E5M1 on Ultra-Violence - episodeNUM=5 mapNUM=1 skillLEVEL=4
episodeNUM=
mapNUM=
skillLEVEL=

# Define addonDIR - dazi TMPFS - Default RetroPie ADDON
addonDIR=/dev/shm/addon
#addonDIR=~/RetroPie/roms/ports/doom/addon

# ==========================================
loadM0Ds() # Scripted L00P Supports Loading Any Number of [doomMOD#s] when Defined
{
# Prepare [doomMOD#s] IF DEFINED - ZIPs are Extracted to [addonDIR] - Symbolic LInks created for ALL 0THER File Types - Numeric 0rder Dynamically updated
if [[ ! "${!rollingM0D}" == "" ]]; then if [[ "${!rollingM0D}" == *".zip" ]] || [[ "${!rollingM0D}" == *".ZIP" ]]; then unzip -qq -o "${!rollingM0D}" -d "$addonDIR" > /dev/null 2>&1; else ln -s "${!rollingM0D}" "$addonDIR/0${addonDIRcount}_$(basename "${!rollingM0D}" )"; fi; fi > /dev/null 2>&1
count=$(( $count + 1 )) # Increase count by+1
rollingM0D="doomMOD${count}" # Apply Increased count to [doomMOD#]
if [[ ! "${!rollingM0D}" == "" ]]; then addonDIRcount=$(( $addonDIRcount + 1 )) && loadM0Ds; fi # Prepare more [doomMOD#s] IF DEFINED
}

# Prepare WARP and DIFFICULTY Settings For [lzdoom-dazi+warp]
if [ ! "$episodeNUM" == "" ] || [ ! "$mapNUM" == "" ]; then # 0nly Update [-warp*] in [emulators.cfg] IF the Parameters are DEFINED
	if [ "$skillLEVEL" == "" ]; then skillLEVEL=3; fi # Set DEFAULT DIFFICULTY [Hurt me plenty] if NOT DEFINED
	sed -i "s/-warp.*/-warp\ $episodeNUM\ $mapNUM\ -skill\ $skillLEVEL\"/g" /opt/retropie/configs/ports/doom/emulators.cfg #Update [-warp*] in [emulators.cfg]
fi

mkdir "$addonDIR" > /dev/null 2>&1 # Prepare addonDIR
count=1 # Set Initial Count
rollingM0D="doomMOD${count}"
if [ ! "$(find $addonDIR -maxdepth 1 -type f | wc -l )" == 0 ] || [ ! "$(find $addonDIR -maxdepth 1 -type l | wc -l )" == 0 ]; then addonDIRcount=$(( $count + $(find $addonDIR -maxdepth 1 -type f | wc -l ) + $(find $addonDIR -maxdepth 1 -type l | wc -l ) )); else addonDIRcount=$count; fi # Count Current Files/Links in ADDONS - Update addonDIRcount
loadM0Ds # Load D00M M0Ds in Numeric 0rder
# ==========================================

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"
