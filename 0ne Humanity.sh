# https://github.com/RapidEdwin08/dazi  #v2022.09

#!/bin/bash
# https://github.com/RapidEdwin08/dazi  #v2022.12

# Define [D00M.WAD] - /full/path/to/doom.wad
doomWAD=~/RetroPie/roms/ports/doom/doom2.wad

# 0ptional Define As Many [doomMOD#s] As Needed Starting with #1 - Ascending Numeric 0rder
doomMOD1=~/RetroPie/roms/ports/doom/mods/one-humanity.wad

# 0ptional WARP and DIFFICULTY Settings - Leave episodeNUM= *BLANK* For Doom II MAPs - eg. Doom II MAP31 Nightmare! -> episodeNUM= mapNUM=31 skillLEVEL=5
episodeNUM=
mapNUM=
skillLEVEL=

# Define addonDIR  -  /dev/shm/addon  -  ~/RetroPie/roms/ports/doom/addon  -  /opt/retropie/configs/ports/prboom-plus/autoload/doom-all
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

# DAZI=M0D=LOADER - Update doomWAD[-warp] IF WARP Settings are DEFINED
if [ ! "$mapNUM" == "" ]; then doomWAD="${addonDIR%/*}/$(basename "${doomWAD}" | cut -d. -f1 )-warp.$(basename "${doomWAD}" | sed "s/^.*\.//")"; fi
bash /opt/retropie/configs/ports/doom/lzdoom-dazi.sh loadmod "$0" > /dev/null 2>&1 # Load M0Ds with DAZI=M0D=LOADER

# RUN D00M P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"

