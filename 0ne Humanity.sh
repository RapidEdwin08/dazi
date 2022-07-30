# https://github.com/RapidEdwin08/dazi  #v2022.08

# Define [D00M.WAD] - /full/path/to/doom.wad
doomWAD=~/RetroPie/roms/ports/doom/doom2.wad

# 0ptional Define As Many [doomMOD#s] As Needed Starting with #1 - Ascending Numeric 0rder
doomMOD1=~/RetroPie/roms/ports/doom/mods/one-humanity.wad
if [ -f ~/RetroPie/roms/ports/doom/mods/one-humanity.zip ]; then doomMOD1=~/RetroPie/roms/ports/doom/mods/one-humanity.zip; fi

# 0ptional WARP and DIFFICULTY Settings For [lzdoom-dazi+warp] - eg. Ultimate Doom SIGIL E5M1 on Ultra-Violence - episodeNUM=5 mapNUM=1 skillLEVEL=4
episodeNUM=
mapNUM=
skillLEVEL=

# Define addonDIR - dazi TMPFS - Default RetroPie ADDON
addonDIR=/dev/shm/addon
#addonDIR=~/RetroPie/roms/ports/doom/addon

# ==========================================
# one-humanity.wad CHECK
if [ ! -f "$doomMOD1" ]; then
	# get-one-humanity Dialog
	echo "doomMOD1=$doomMOD1" > /dev/shm/get-one-humanity.sh
	echo 'onehumanityGET=$(' >> /dev/shm/get-one-humanity.sh
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "One Humanity is a new level for the 1994 id Software release DOOM® II"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "by John Romero to support the people of Ukraine and the humanitarian"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "efforts of the Red Cross and the UN Central Emergency Response Fund."' >> /dev/shm/get-one-humanity.sh
	echo 'echo "100% of the proceeds go toward this support."' >> /dev/shm/get-one-humanity.
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "GO TO:"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "https://romero.com/shop/p/onehumanity"' >> /dev/shm/get-one-humanity.sh
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "DOWNLOAD [one-humanity.wad]"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "€5.00 EUR"' >> /dev/shm/get-one-humanity.sh
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "PLACE [one-humanity.wad] 0R [one-humanity.zip] IN:"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "$doomMOD1"' >> /dev/shm/get-one-humanity.sh
	echo ')' >> /dev/shm/get-one-humanity.sh
	echo 'dialog --no-collapse --title " ** REQUIRED **  [$doomMOD1] " --ok-label OK --msgbox "$onehumanityGET"  25 75' >> /dev/shm/get-one-humanity.sh
	sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch "/dev/shm/get-one-humanity.sh" </dev/tty > /dev/tty
	exit 0
fi
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
