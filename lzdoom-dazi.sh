#!/usr/bin/env bash

daziLOGO=$(
echo ""
echo '                            /\      |\   '
echo '                           |  \    / |   '
echo '                           |   \  |  /   '
echo '                            \  _|/_ |   '
echo '                             /      \   '
echo '                            _|       |_   '
echo '                           / /(|   |)\ \   '
echo '                         /  /    _    \  \   '
echo '                        /  |   /   \   |  \   '
echo '                       /    \__\___/__/    |\   '
echo '                      |                    | \   '
echo '                      |                    |  |   '
echo '                       \    \            //   |   '
echo '                        |     \ ____  __//    |   '
echo '                        |               /    /    '
echo '                       /______wwww  wwww____/   '
echo ""
echo "       ------------------------------------------------------- "
)


scriptREF=$(
echo ""
echo "- WHAT IS DAZI?"
echo 'D00M AddOn Zip Integration'
echo ""
echo "- WHAT DOES IT DO?"
echo "Integration of [D00M-M0D.ZIPs] for [lzdoom] in RetroPie"
echo ""
echo "- HOW DOES IT WORK?"
echo '[DAZI-Templates.sh] will Extract [D00M-M0D.ZIPs] into [/dev/shm/addon]'
echo '[lzdoom-dazi] Entry in [emulators.cfg] will point to [/dev/shm/addon/*]'
echo ""
echo "- HOW TO USE:"
echo 'Place your [D00M-M0D] FILEs into a [.ZIP] in [..roms/ports/doom/mods/*]'
echo 'Replace all [D00M.sh] Scripts with [DAZI-Templates.sh] in [/roms/ports]'
echo 'CHOOSE [lzdoom-dazi] D00M P0RT to RUN [DAZI-Template.sh] + [*.ZIPs]'
)

daziFILES=$(
echo ""
echo " [lzdoom] Config File: /opt/retropie/configs/ports/emulators.cfg"
echo " [doom] Launch Files: ~/RetroPie/roms/ports/Doom/*D00M*.sh"
echo ""
)

zipREFmod=$(
echo ""
echo "        # PLACE YOUR [D00M-M0D] FILES INTO A [D00M-M0D.ZIP] #"
echo "    NAME THEM ACCORDINGLY IF A PARTICULAR L0ADING 0RDER IS NEEDED"
echo ""
echo '                # EXAMPLE [D00M-M0D.ZIP] CONTENTS #'
echo '                 ./D00M-M0D.ZIP/01-FileToLoad.wad'
echo '                 ./D00M-M0D.ZIP/02-FileToLoad.deh'
echo '                 ./D00M-M0D.ZIP/03-FileToLoad.pk3'
echo ''
echo " # MODIFY [DAZI-Template.sh] TO INCLUDE YOUR [IWAD] + [D00M-M0D.ZIP] #"
echo "            0ptional D00M-M0D.ZIP Entry Available if needed"
echo ""
echo '              # EXAMPLE [DAZI-Template.sh] CONTENTS #'
echo '          doomWAD=~/RetroPie/roms/ports/doom/doom2.wad'
echo '      modZIP=~/RetroPie/roms/ports/doom/mods/BrutalDoom.zip'
echo ' optionalZIP=~/RetroPie/roms/ports/doom/mods/HellOnEarthStarterPack.zip'
echo ""
echo "     # HOW TO PRE-LOAD D00M M0Ds WITH [DAZI] FOR 0THER ROMs #"
echo "      Select and Load a D00M-MOD using the [DAZI-Template.sh]"
echo "       PRESS [A] BUTTON TO CONFIGURE *(Before the ROM Loads)*"
echo "                     * [EXIT WITHOUT LAUNCHING] *"
echo "  The Last D00M-M0D Selected will Still be Loaded in [/dev/shm/addon]"
echo "  Now Select any 0ther Desired D00M R0M and Launch with [lzdoom-dazi]"
)

daziSH=$(
echo '#!/bin/bash'
echo '# https://github.com/RapidEdwin08/dazi'
echo ''
echo '# INPUT D00M.WAD + D00M-M0D.ZIPs'
echo 'doomWAD=~/RetroPie/roms/ports/doom/doom1.wad'
echo 'modZIP='
echo 'optionalZIP='
echo ''
echo '# Define addonDIR - eg. ~/RetroPie/roms/ports/doom/addon #Default'
echo 'addonDIR=/dev/shm/addon #tmpfs'
echo ''
echo '# Extract D00M-M0D.zip + 0ptional-D00M-M0D.zip into addonDIR If Defined'
echo 'mkdir "$addonDIR" > /dev/null 2>&1'
echo 'if [ ! "$modZIP" == "" ]; then unzip -qq -o $modZIP -d $addonDIR > /dev/null 2>&1; fi'
echo 'if [ ! "$optionalZIP" == "" ]; then unzip -qq -o $optionalZIP -d $addonDIR > /dev/null 2>&1; fi'
echo ''
echo '# RUN D00M P0RT'
echo '"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"'
echo ''
echo '# CASE#1: [runcommand.log] FILLED = ROM was Launched/Played -> DELETE the [addonDIR]'
echo '# CASE#2: [runcommand.log] BLANK = EXIT WITHOUT LAUNCHING -> KEEP the [addonDIR]'
echo '# USE CASE#2 to Pre-Load a M0D in [addonDIR] BY SELECTING [EXIT WITHOUT LAUNCHING]'
echo 'if [ ! "$(cat /dev/shm/runcommand.log)" == "''" ]; then rm "$addonDIR" -R -f > /dev/null 2>&1; fi'
echo ''
)

# This is a verified working lzdoom [emulators.cfg] file
# Pulled from a Rpi4 running RetroPie v4.8
lzdoomCFGemu=$(
echo 'lzdoom = "DOOMWADDIR=/home/pi/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES%"'
echo 'default = "lzdoom"'
echo 'lzdoom-addon = "DOOMWADDIR=/home/pi/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/pi/RetroPie/roms/ports/doom/addon/*"'
echo 'lzdoom-dazi = "DOOMWADDIR=/home/pi/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES% -file /dev/shm/addon/*"'
)

daziEMUcfg=$(
echo ""
echo "           [DAZI] is intended for use with [lzdoom]... "
echo "     Recommended INSTALLING [lzdoom] FIRST... "
echo ""
echo 'If Not a GENERIC [emulators.cfg] will be Genterated for you...'
echo "But you may experience Mixed Results with the GENERIC [emulators.cfg]"
)

mainMENU()
{

# WARN IF [..ports/doom/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/doom/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "$daziEMUcfg"  25 75
fi
# Confirm Configurations
confCONFIG=$(dialog --stdout --no-collapse --title " D00M AddOn ZIP Integration [DAZI] for [lzdoom] by: RapidEdwin08 [202203]" \
	--ok-label OK --cancel-label EXIT \
	--menu "$scriptREF" 25 75 20 \
	1 "><  GET [DAZI-Templates.sh] for [/roms/ports]   ><" \
	2 "><  INSTALL [lzdoom-dazi] to [emulators.cfg]  ><" \
	3 "><  REMOVE [lzdoom-dazi] from [emulators.cfg]  ><" \
	4 "><  REFERENCES  ><")

if [ "$confCONFIG" == '1' ]; then getDAZIsh; fi 
if [ "$confCONFIG" == '2' ]; then installDAZI; fi

# WIPE [lzdoom-dazi] Settings
if [ "$confCONFIG" == '3' ]; then
	cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -v 'lzdoom-dazi =' > /dev/shm/emulators.cfg
	sed -i 's/default\ =.*/default\ =\ \"lzdoom\"/g' /dev/shm/emulators.cfg
	mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg 2>/dev/null
	
	dialog --no-collapse --title "REMOVE [DAZI] for [RetroPie]  *COMPLETE!*" --ok-label Back --msgbox "$daziLOGO $daziFILES"  25 75
	tput reset
	mainMENU
fi

if [ "$confCONFIG" == '4' ]; then
	dialog --no-collapse --title "[DAZI] for [RetroPie] REFERENCES" --ok-label Back --msgbox "$daziLOGO $zipREFmod"  25 75
	mainMENU
fi

# QUIT if N0T Confirmed
if [ "$confCONFIG" == '' ]; then
	tput reset
	exit 0
fi

tput reset
exit 0
}

installDAZI()
{
tput reset
# =====================================
# Create [emulators.cfg] from a verified working [emulators.cfg] file If N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then echo "$lzdoomCFGemu" > /opt/retropie/configs/ports/doom/emulators.cfg; fi

# Backup emulators.cfg if not exist already
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi ]; then cp /opt/retropie/configs/ports/doom/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi 2>/dev/null; fi

# Add [dazi] to [emulators.cfg]
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -v 'lzdoom-dazi =' > /dev/shm/emulators.cfg
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep 'lzdoom-addon =' > /dev/shm/emulators.dazi
if [ "$(cat /dev/shm/emulators.dazi | grep -q 'lzdoom-addon =' ; echo $?)" == '1' ]; then
	echo 'lzdoom-addon = "DOOMWADDIR=/home/pi/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/pi/RetroPie/roms/ports/doom/addon/*"' > /dev/shm/emulators.dazi
	echo 'lzdoom-addon = "DOOMWADDIR=/home/pi/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/pi/RetroPie/roms/ports/doom/addon/*"' >> /dev/shm/emulators.cfg
fi

# Create [dazi] entry based on current [lzdoom-addon] entry in [emulators.cfg]
sed -i 's/lzdoom-addon\ =/lzdoom-dazi\ =/g' /dev/shm/emulators.dazi
sed -i 's/~\/RetroPie\/roms\/ports\/doom\/addon\//\/dev\/shm\/addon\//g' /dev/shm/emulators.dazi
sed -i 's/\/home\/pi\/RetroPie\/roms\/ports\/doom\/addon\//\/dev\/shm\/addon\//g' /dev/shm/emulators.dazi
cat /dev/shm/emulators.dazi >> /dev/shm/emulators.cfg

# Replace [emulators.cfg]
mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg 2>/dev/null

# Configure [dazi] as DEFAULT in [emulators.cfg]
sed -i 's/default\ =.*/default\ =\ \"lzdoom-dazi\"/g' /opt/retropie/configs/ports/doom/emulators.cfg

# Cleanup
rm /dev/shm/emulators.cfg 2>/dev/null
rm /dev/shm/emulators.dazi 2>/dev/null

# FINISHED
dialog --no-collapse --title "INSTALL [DAZI] for [RetroPie]  *COMPLETE!* " --ok-label Back --msgbox "$daziLOGO $zipREFmod"  25 75

mainMENU
}

getDAZIsh()
{
tput reset
# =====================================
echo "$daziSH" > ~/RetroPie/roms/ports/Doom\ \(DAZI\).sh
sed -i 's/doom1.wad/doom1.wad/g' ~/RetroPie/roms/ports/Doom\ \(DAZI\).sh

echo "$daziSH" > ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh
sed -i 's/doom1.wad/freedoom1.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh

echo "$daziSH" > ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh
sed -i 's/doom1.wad/freedoom2.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh

# Get SIGIL If Internet Connection Available
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	wget --progress=bar:force https://romero.com/s/SIGIL_v1_21.zip -P /dev/shm
	unzip -qq -o /dev/shm/SIGIL_v1_21.zip -d /dev/shm
	sudo apt-get install zip
	zip -mj /dev/shm/SIGIL_v1_21/SIGIL_COMPAT.zip /dev/shm/SIGIL_v1_21/SIGIL_COMPAT_v1_21.wad
	mkdir ~/RetroPie/roms/ports/doom/mods 2>/dev/null
	mv /dev/shm/SIGIL_v1_21/SIGIL_COMPAT.zip ~/RetroPie/roms/ports/doom/mods 2>/dev/null
	echo "$daziSH" > ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	if [ -f ~/RetroPie/roms/ports/doom/doom.wad ]; then
		sed -i 's/doom1.wad/doom.wad/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	else
		mv /dev/shm/SIGIL_v1_21/SIGIL_v1_21.wad ~/RetroPie/roms/ports/doom 2>/dev/null
		sed -i 's/doom1.wad/SIGIL_v1_21.wad/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	fi
	sed -i 's/modZIP=.*/modZIP=~\/RetroPie\/roms\/ports\/doom\/mods\/SIGIL_COMPAT.zip/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	rm /dev/shm/SIGIL_v1_21.zip 2>/dev/null
	rm /dev/shm/SIGIL_v1_21 -R -f 2>/dev/null
	rm /dev/shm/__MACOSX -R -f 2>/dev/null
fi

# FINISHED
dialog --no-collapse --title "GET [DAZI-Templates.sh] for [../roms/ports] *COMPLETE!* " --ok-label Back --msgbox "$daziLOGO $zipREFmod"  25 75

mainMENU
}

mainMENU

tput reset
exit 0
