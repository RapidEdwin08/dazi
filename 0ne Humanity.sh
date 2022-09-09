# https://github.com/RapidEdwin08/dazi  #v2022.09

# Define [D00M.WAD] - /full/path/to/doom.wad
doomWAD=~/RetroPie/roms/ports/doom/doom2.wad

# 0ptional Define As Many [doomMOD#s] As Needed Starting with #1 - Ascending Numeric 0rder
doomMOD1=~/RetroPie/roms/ports/doom/mods/one-humanity.wad

# 0ptional WARP and DIFFICULTY Settings - Leave episodeNUM= *BLANK* For Doom II MAPs - eg. Doom II MAP31 Nightmare! -> episodeNUM= mapNUM=31 skillLEVEL=5
episodeNUM=
mapNUM=
skillLEVEL=

# Define addonDIR  -  /dev/shm/addon  -  ~/RetroPie/roms/ports/doom/addon  -  /opt/retropie/configs/ports/prboom-plus/autoload/doom-all
#addonDIR=/dev/shm/addon
addonDIR=~/RetroPie/roms/ports/doom/addon

# ==========================================
# one-humanity.wad CHECK
if [ -f ~/RetroPie/roms/ports/doom/one-humanity.wad ]; then doomMOD1=~/RetroPie/roms/ports/doom/one-humanity.wad; fi
if [ -f ~/RetroPie/roms/ports/doom/one-humanity.zip ]; then doomMOD1=~/RetroPie/roms/ports/doom/one-humanity.zip; fi
if [ -f ~/RetroPie/roms/ports/doom/one-humanity.zip ]; then doomMOD1=~/RetroPie/roms/ports/doom/one-humanity.7z; fi
if [ -f ~/RetroPie/roms/ports/doom/mods/one-humanity.wad ]; then doomMOD1=~/RetroPie/roms/ports/doom/mods/one-humanity.wad; fi
if [ -f ~/RetroPie/roms/ports/doom/mods/one-humanity.zip ]; then doomMOD1=~/RetroPie/roms/ports/doom/mods/one-humanity.zip; fi
if [ -f ~/RetroPie/roms/ports/doom/mods/one-humanity.zip ]; then doomMOD1=~/RetroPie/roms/ports/doom/mods/one-humanity.7z; fi
if [ ! -f "$doomMOD1" ]; then
	# get-one-humanity Dialog
	echo "doomMOD1=$doomMOD1" > /dev/shm/get-one-humanity.sh
	echo 'onehumanityGET=$(' >> /dev/shm/get-one-humanity.sh
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "One Humanity is a new level for the 1994 id Software release DOOM® II"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "by John Romero to support the people of Ukraine and the humanitarian"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "efforts of the Red Cross and the UN Central Emergency Response Fund."' >> /dev/shm/get-one-humanity.sh
	echo 'echo "100% of the proceeds go toward this support."' >> /dev/shm/get-one-humanity.sh
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "GO TO:"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "https://romero.com/shop/p/onehumanity"' >> /dev/shm/get-one-humanity.sh
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "DOWNLOAD [one-humanity.wad]"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "€5.00 EUR"' >> /dev/shm/get-one-humanity.sh
	echo 'echo ""' >> /dev/shm/get-one-humanity.sh
	echo 'echo "PLACE [one-humanity.wad] 0R [.zip] IN:"' >> /dev/shm/get-one-humanity.sh
	echo 'echo "$doomMOD1"' >> /dev/shm/get-one-humanity.sh
	echo ')' >> /dev/shm/get-one-humanity.sh
	echo 'dialog --no-collapse --title " ** REQUIRED **  [$doomMOD1] " --ok-label OK --msgbox "$onehumanityGET"  25 75' >> /dev/shm/get-one-humanity.sh
	sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch "/dev/shm/get-one-humanity.sh" </dev/tty > /dev/tty
	exit 0
fi
# ========================DO=NOT=MODIFY========================
loadM0Ds() # Scripted L00P Supports Loading Any Number of [doomMOD#s] when Defined
{ # Prepare [doomMOD#s] IF DEFINED - ZIPs are Extracted to [addonDIR] - Symbolic LInks created for ALL 0THER File Types - Numeric 0rder Dynamically updated
if [[ ! "${!rollingM0D}" == "" ]]; then if [[ "${!rollingM0D}" == *".zip" ]] || [[ "${!rollingM0D}" == *".ZIP" ]]; then unzip -qq -o "${!rollingM0D}" -d "$addonDIR"; elif [[ "${!rollingM0D}" == *".7z" ]] || [[ "${!rollingM0D}" == *".7Z" ]]; then 7z x "${!rollingM0D}" -aoa -o"$addonDIR" > /dev/null 2>&1; elif [[ "${!rollingM0D}" == *"prboom.cfg" ]]; then mkdir "$addonDIR"/".0ther"; rm ""$addonDIR"/".0ther"/prboom.cfg" 2>/dev/null; ln -s "${!rollingM0D}" ""$addonDIR"/".0ther"/prboom.cfg" 2>/dev/null; else ln -s "${!rollingM0D}" "$addonDIR/0${addonDIRcount}_$(basename "${!rollingM0D}" )"; fi; fi > /dev/null 2>&1
if [ -f "$addonDIR/prboom.cfg" ]; then mkdir "$addonDIR"/".0ther" 2>/dev/null; mv "$addonDIR/prboom.cfg" ""$addonDIR"/".0ther"/prboom.cfg" > /dev/null 2>&1; fi; if [ ! "$(find $addonDIR -maxdepth 1 -type f -iname *.txt)" == "" ]; then ( for f in $(find $addonDIR -maxdepth 1 -type f -iname *.txt); do mkdir "$addonDIR"/".0ther" > /dev/null 2>&1; mv "$f" "$addonDIR"/".0ther" 2>/dev/null; done ); fi # Post ZIP/MOD Actions - Move prboom.cfg and TXT Files to .0ther
count=$(( $count + 1 )) # Increase count by+1
rollingM0D="doomMOD${count}" # Apply Increased count to [doomMOD#]
if [[ ! "${!rollingM0D}" == "" ]]; then addonDIRcount=$(( $addonDIRcount + 1 )); loadM0Ds; fi } # Prepare more [doomMOD#s] IF DEFINED
# Prepare WARP and DIFFICULTY Settings For [lzdoom-dazi+warp] - 0nly Update doom[-warp].wad IF the Parameters are DEFINED - Set DEFAULT DIFFICULTY [Hurt me plenty] if NOT DEFINED - Update [-warp*] in [emulators.cfg] - If addonDIR is NOT DEFAULT [~/RetroPie/roms/ports/doom/] Create Symbolic Link to [doomWAD] - set doomWAD=[addonDIRroot/doomWAD]
if [ ! "$episodeNUM" == "" ] || [ ! "$mapNUM" == "" ]; then ln -s "${doomWAD}" "${addonDIR%/*}/$(basename "${doomWAD}" | cut -d. -f1 )-warp.$(basename "${doomWAD}" | sed "s/^.*\.//")" > /dev/null 2>&1; doomWAD="${addonDIR%/*}/$(basename "${doomWAD}" | cut -d. -f1 )-warp.$(basename "${doomWAD}" | sed "s/^.*\.//")"; if [ "$skillLEVEL" == "" ]; then skillLEVEL=3; fi; sed -i "s/-warp.*/-warp\ $episodeNUM\ $mapNUM\ -skill\ $skillLEVEL;\ popd\"/g" /opt/retropie/configs/ports/doom/emulators.cfg; else if [[ ! "$(dirname ${doomWAD} )" == "/home/$USER/RetroPie/roms/ports/doom/addon" ]]; then ln -s "${doomWAD}" "${addonDIR%/*}/$(basename "${doomWAD}" | cut -d. -f1 ).$(basename "${doomWAD}" | sed "s/^.*\.//")" > /dev/null 2>&1; doomWAD="${addonDIR%/*}/$(basename "${doomWAD}" | cut -d. -f1 ).$(basename "${doomWAD}" | sed "s/^.*\.//")"; fi; fi
mkdir "${addonDIR%/*}" > /dev/null 2>&1; mkdir "$addonDIR" > /dev/null 2>&1; mv "${addonDIR%/*}/$(basename $doomWAD | cut -d. -f1)/prboom.cfg" "${addonDIR%/*}/$(basename $doomWAD | cut -d. -f1)/prboom.cfg.last" > /dev/null 2>&1 # Prepare addonDIR - Move previous prboom.cfg
count=1; rollingM0D="doomMOD${count}" # Set Initial Count
if [ ! "$(find $addonDIR -maxdepth 1 -type f | wc -l )" == 0 ] || [ ! "$(find $addonDIR -maxdepth 1 -type l | wc -l )" == 0 ]; then addonDIRcount=$(( $count + $(find $addonDIR -maxdepth 1 -type f | wc -l ) + $(find $addonDIR -maxdepth 1 -type l | wc -l ) )); else addonDIRcount=$count; fi # Count Current Files/Links in ADDONS - Update addonDIRcount
loadM0Ds # Load D00M M0Ds in Numeric 0rder
# ========================DO=NOT=MODIFY========================

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"
