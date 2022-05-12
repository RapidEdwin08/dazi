#!/usr/bin/env bash
versionDAZI=202205
modDIRzips=~/RetroPie/roms/ports/doom/mods/
modDIRroms=/home/pi/RetroPie/roms/ports/doom/addon/
modDIRtmpfs=/dev/shm/addon/

zdoomCFGrp=/opt/retropie/configs/ports/doom/lzdoom.ini
zdoomCFGroms=~/RetroPie/roms/ports/doom/lzdoom.ini

MENUlaunchDOOM=BACK

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

daziHUD=$(
echo ""
echo '+--------------------------------------------------------------------+   '
echo '|      | /|  |  |            |   (\\   |     /|    |_| ..  ports.... |   '
echo '|      | /|  |  |  2  3  4   |    \||  |     /|    |_| ..  ..doom... |   '
echo '|      | ~|~ | %|            |  __(_"; |     ~|~ % |_| ..  ....addon |   '
echo '|      | /|  |  |            | /    \  |     /|    |_| ..  ..shm.... |   '
echo '| AMMO | HEALTH |  5  6  7   |{}___)\)_|    ARMOR  |#| ..  dev...... |   '
echo '+--------------------------------------------------------------------+   '
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
echo ""
echo "DAZI includes [dazi-mod-loader] for [lzdoom-addon] + [lzdoom-dazi]"
echo "[dazi-mod-loader] Loads when [lzdoom-addon]/[lzdoom-dazi] is Launched"
echo "You can also access [dazi-mod-loader] from the this Script"
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
echo 'mkdir "$addonDIR" > /dev/null 2>&1'
echo ''
)

# This is a verified working lzdoom [emulators.cfg] file
# Pulled from a Rpi4 running RetroPie v4.8
lzdoomCFGemu=$(
echo "lzdoom = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES%\""
echo 'default = "lzdoom"'
echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/$USER/RetroPie/roms/ports/doom/addon/*\""
)

daziEMUcfg=$(
echo ""
echo "           [DAZI] is intended for use with [lzdoom]... "
echo "         Recommended INSTALLING [lzdoom] FIRST... "
echo ""
echo 'If N0T a GENERIC lzdoom based [emulators.cfg] will be Genterated...'
echo "But you may experience Mixed Results with the GENERIC [emulators.cfg]"
)

mainMENU()
{

# WARN IF [..ports/doom/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/doom/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "$daziEMUcfg"  25 75
fi
# Confirm Configurations
confCONFIG=$(dialog --stdout --no-collapse --title " D00M AddOn ZIP Integration [DAZI] for [lzdoom] by: RapidEdwin08 [$versionDAZI]" \
	--ok-label OK --cancel-label EXIT \
	--menu "$scriptREF" 25 75 20 \
	1 "><  DAZI [M0D LOADER]  ><" \
	2 "><  GET [DAZI-Templates.sh] for [/roms/ports]   ><" \
	3 "><  INSTALL [lzdoom-dazi] to [emulators.cfg]  ><" \
	4 "><  REMOVE [lzdoom-dazi] from [emulators.cfg]  ><" \
	5 "><  REFERENCES  ><")

if [ "$confCONFIG" == '1' ]; then DMLmainMENU; fi 
if [ "$confCONFIG" == '2' ]; then getDAZIsh; fi 
if [ "$confCONFIG" == '3' ]; then installDAZI; fi

# WIPE [lzdoom-dazi] Settings
if [ "$confCONFIG" == '4' ]; then
	# Backup emulators.cfg if not exist already
	if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi ]; then cp /opt/retropie/configs/ports/doom/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi 2>/dev/null; fi
	
	cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -v 'lzdoom-dazi-' | grep -v 'lzdoom-dazi =' | grep -v 'default =' > /dev/shm/emulators.cfg
	echo 'default = "lzdoom"' >> /dev/shm/emulators.cfg
	mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg 2>/dev/null
	
	# Remove [lzdoom-dazi] from  [runcommand-onstart.sh]
	if [ -f /opt/retropie/configs/all/runcommand-onstart.sh ]; then
		# Backup [runcommand-onstart.sh] not exist already
		if [ ! -f /opt/retropie/configs/all/runcommand-onstart.sh.bakdazi ]; then cp /opt/retropie/configs/all/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh.bakdazi 2>/dev/null; fi	
		
		# Rebuild [runcommand-onstart.sh] without [lzdoom-dazi]
		cat /opt/retropie/configs/all/runcommand-onstart.sh | grep -v 'lzdoom-dazi' > /dev/shm/runcommand-onstart.sh
		mv /dev/shm/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh
	fi
	
	# Remove [dazi-mod-loader.sh]
	rm /opt/retropie/configs/ports/doom/dazi-mod-loader.sh

	dialog --no-collapse --title "REMOVE [DAZI] for [RetroPie]  *COMPLETE!*" --ok-label Back --msgbox "$daziLOGO $daziFILES"  25 75
	tput reset
	mainMENU
fi

if [ "$confCONFIG" == '5' ]; then
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
# Check If Internet Connection Available
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	sudo apt-get install zip
	sudo apt-get install unzip
else
	# No Internet - Back to Main Menu
	dialog --no-collapse --title "               [ERROR]               " --msgbox "   *INTERNET CONNECTION REQUIRED*"  25 75
	mainMENU
fi

# Create [emulators.cfg] from a verified working [emulators.cfg] file If N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then echo "$lzdoomCFGemu" > /opt/retropie/configs/ports/doom/emulators.cfg; fi

# Backup emulators.cfg if not exist already
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi ]; then cp /opt/retropie/configs/ports/doom/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi 2>/dev/null; fi

# Add [dazi] to [emulators.cfg]
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -v 'lzdoom-dazi-' | grep -v 'lzdoom-dazi =' > /dev/shm/emulators.cfg
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep 'lzdoom-addon' > /dev/shm/emulators.dazi
if [ "$(cat /dev/shm/emulators.dazi | grep -q 'lzdoom-addon =' ; echo $?)" == '1' ]; then
	echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/$USER/RetroPie/roms/ports/doom/addon/*\"" > /dev/shm/emulators.dazi
	echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 +vid_renderer 1 +'snd_mididevice -3' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/$USER/RetroPie/roms/ports/doom/addon/*\"" >> /dev/shm/emulators.cfg
fi

# Create [dazi] entry based on current [lzdoom-addon] entry in [emulators.cfg]
sed -i 's/lzdoom-addon/lzdoom-dazi/g' /dev/shm/emulators.dazi
sed -i 's/~\/RetroPie\/roms\/ports\/doom\/addon\//\/dev\/shm\/addon\//g' /dev/shm/emulators.dazi
sed -i "s/\/home\/$USER\/RetroPie\/roms\/ports\/doom\/addon\//\/dev\/shm\/addon\//g" /dev/shm/emulators.dazi
cat /dev/shm/emulators.dazi >> /dev/shm/emulators.cfg

# Replace [emulators.cfg]
mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg 2>/dev/null

# Configure [dazi] as DEFAULT in [emulators.cfg]
sed -i 's/default\ =.*/default\ =\ \"lzdoom-dazi\"/g' /opt/retropie/configs/ports/doom/emulators.cfg

# Cleanup
rm /dev/shm/emulators.cfg 2>/dev/null
rm /dev/shm/emulators.dazi 2>/dev/null

# Update [runcommand-onstart.sh] to BLANK the [runcommand.log] 0NLY IF [lzdoom-dazi] is Called
# Ensures the PRE-LOAD D00M-M0Ds Using [EXIT WITHOUT LAUNCHING] Feature remains Functional
if [ ! -f /opt/retropie/configs/all/runcommand-onstart.sh ]; then touch /opt/retropie/configs/all/runcommand-onstart.sh; fi

# Backup [runcommand-onstart.sh] not exist already
if [ ! -f /opt/retropie/configs/all/runcommand-onstart.sh.bakdazi ]; then cp /opt/retropie/configs/all/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh.bakdazi 2>/dev/null; fi

# Rebuild [runcommand-onstart.sh] with [lzdoom-dazi]
if [ "$(cat /opt/retropie/configs/all/runcommand-onstart.sh | tail -n 1 | grep -q "lzdoom-dazi" ; echo $?)" == '1' ]; then
	# Needs to be the LAST Line in [runcommand-onstart.sh] to Properly BLANK the [runcommand.log]
	cat /opt/retropie/configs/all/runcommand-onstart.sh | grep -v 'lzdoom-dazi' > /dev/shm/runcommand-onstart.sh
	#echo 'if [[ "$2" == *"lzdoom-dazi"* ]]; then cat /dev/null > /dev/shm/runcommand.log; fi #For Use With [lzdoom-dazi] + [ExitWithoutLaunching] #Line Should be LAST' >> /dev/shm/runcommand-onstart.sh
	echo 'if [[ "$2" == *"lzdoom-addon"* ]] || [[ "$2" == *"lzdoom-dazi"* ]]; then echo "$3" > /dev/shm/runcommand.log && sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch "/opt/retropie/configs/ports/doom/dazi-mod-loader.sh" </dev/tty > /dev/tty; fi #For Use With [lzdoom-dazi] + [ExitWithoutLaunching] #Line Should be LAST' >> /dev/shm/runcommand-onstart.sh
	mv /dev/shm/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh
fi

# Get DAZI M0D LOADER
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/dazi-mod-loader -P /dev/shm
mv /dev/shm/dazi-mod-loader.sh /opt/retropie/configs/ports/doom/dazi-mod-loader.sh
sudo chmod 755 /opt/retropie/configs/ports/doom/dazi-mod-loader.sh

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
	sudo apt-get install unzip
	mv /dev/shm/SIGIL_v1_21/SIGIL_COMPAT_v1_21.wad /dev/shm/SIGIL_v1_21/01_SIGIL_COMPAT_v1_21.wad
	mv /dev/shm/SIGIL_v1_21/SIGIL_v1_21.wad /dev/shm/SIGIL_v1_21/01_SIGIL_v1_21.wad
	zip -mj /dev/shm/SIGIL_v1_21/SIGIL_COMPAT.zip /dev/shm/SIGIL_v1_21/01_SIGIL_COMPAT_v1_21.wad
	zip -mj /dev/shm/SIGIL_v1_21/SIGIL.zip /dev/shm/SIGIL_v1_21/01_SIGIL_v1_21.wad
	mkdir ~/RetroPie/roms/ports/doom/mods 2>/dev/null
	mv /dev/shm/SIGIL_v1_21/SIGIL.zip ~/RetroPie/roms/ports/doom/mods 2>/dev/null
	mv /dev/shm/SIGIL_v1_21/SIGIL_COMPAT.zip ~/RetroPie/roms/ports/doom/mods 2>/dev/null
	echo "$daziSH" > ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	
	if [ -f ~/RetroPie/roms/ports/doom/doom.wad ]; then
		sed -i 's/doom1.wad/doom.wad/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	else
		#mv /dev/shm/SIGIL_v1_21/SIGIL_v1_21.wad ~/RetroPie/roms/ports/doom 2>/dev/null
		sed -i 's/doom1.wad/freedoom1.wad/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	fi
	sed -i 's/modZIP=.*/modZIP=~\/RetroPie\/roms\/ports\/doom\/mods\/SIGIL.zip/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	rm /dev/shm/SIGIL_v1_21.zip 2>/dev/null
	rm /dev/shm/SIGIL_v1_21 -R -f 2>/dev/null
	rm /dev/shm/__MACOSX -R -f 2>/dev/null
fi

# FINISHED
dialog --no-collapse --title "GET [DAZI-Templates.sh] for [../roms/ports] *COMPLETE!* " --ok-label Back --msgbox "$daziLOGO $zipREFmod"  25 75

mainMENU
}

DMLmainMENU()
{
if [ ! -d $modDIRtmpfs ]; then mkdir $modDIRtmpfs; fi

# WARN IF [..ports/doom/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/doom/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "$daziLOGO"  25 75
fi
# Confirm Configurations
DMLconfCONFIG=$(dialog --stdout --no-collapse --title " [DAZI] M0D LOADER for [lzdoom] by: RapidEdwin08 [$versionDAZI]" \
	--ok-label SELECT --cancel-label "$MENUlaunchDOOM" \
	--menu "\n[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRroms ) \n$daziHUD \n[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRtmpfs ) \n" 25 75 20 \
	1 ">< $MENUlaunchDOOM ><" \
	2 ">< LOAD   [M0D] in [$modDIRtmpfs] (tmpfs) ><" \
	3 ">< REMOVE [M0D] in [$modDIRtmpfs] (tmpfs) ><" \
	4 ">< LOAD   [M0D] in [$modDIRroms] ><" \
	5 ">< REMOVE [M0D] in [$modDIRroms] ><" \
	6 ">< DELETE [lzdoom.ini] Configuration (RESET) ><")

if [ "$DMLconfCONFIG" == '1' ]; then
	cat /dev/null > /dev/shm/runcommand.log
	tput reset
	mainMENU
fi

if [ "$DMLconfCONFIG" == '2' ]; then addonZIPmenuTMPFS; fi
if [ "$DMLconfCONFIG" == '3' ]; then M0DremoveTMPFS; fi

if [ "$DMLconfCONFIG" == '4' ]; then addonZIPmenuROMS; fi
if [ "$DMLconfCONFIG" == '5' ]; then M0DremoveROMS; fi

# DELETE Confirmed - Otherwise Back to Main Menu
if [ "$DMLconfCONFIG" == '6' ]; then
	DMLconfDELETEcfg=$(dialog --stdout --no-collapse --title "               DELETE [lzdoom.ini] Configuration (RESET)              " \
		--ok-label OK --cancel-label BACK \
		--menu "Default: [$zdoomCFGrp]  \nPorts:   [$zdoomCFGroms]\n \n                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  DELETE [lzdoom.ini] Configuration (RESET)  ><" \
		2 "><  BACK  ><")
	# Uninstall Confirmed - Otherwise Back to Main Menu
	if [ "$DMLconfDELETEcfg" == '1' ]; then
		rm $zdoomCFGrp
		rm $zdoomCFGroms
		dialog --no-collapse --title "DELETE [lzdoom.ini] Configuration (RESET) *COMPLETE!*" --ok-label Back --msgbox "Default: [$zdoomCFGrp]  \nPorts:   [$zdoomCFGroms]\n"  25 75
		DMLmainMENU
	fi
DMLmainMENU
fi

# Back if N0T Confirmed
if [ "$DMLconfCONFIG" == '' ]; then
	cat /dev/null > /dev/shm/runcommand.log
	tput reset
	mainMENU
fi

cat /dev/null > /dev/shm/runcommand.log
tput reset
mainMENU
}

addonZIPmenuTMPFS()
{
tput reset
# =====================================

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
done < <( ls -1 $modDIRzips )
#done < <( find "$modDIRzips" -maxdepth 1 -type f -iname "*.zip" )
FILE=$(dialog --title "Select M0D from $modDIRzips" --ok-label SELECT --cancel-label BACK --menu "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRtmpfs )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
    #selectFILE=$(readlink -f $(ls -1 $modDIRzips | sed -n "`echo "$FILE p" | sed 's/ //'`"))
	selectFILE=$(ls -1 $modDIRzips | sed -n "`echo "$FILE p" | sed 's/ //'`")
	if [[ "$selectFILE" == *".zip" ]] || [[ "$selectFILE" == *".ZIP" ]]; then
		unzip -qq -o $modDIRzips/$selectFILE -d $modDIRtmpfs
	else
		cp $modDIRzips/$selectFILE $modDIRtmpfs
	fi
	dialog --no-collapse --title "  M0D Added: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h /dev/shm |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRtmpfs )\n"  25 75
	addonZIPmenuTMPFS
fi

DMLmainMENU
}

M0DremoveTMPFS()
{
tput reset
# =====================================
if [ "$(ls -1 $modDIRtmpfs)" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRtmpfs )\n"  25 75
	DMLmainMENU
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
done < <( ls -1 $modDIRtmpfs )
#done < <( find "$modDIRzips" -maxdepth 1 -type f -iname "*.zip" )
FILE=$(dialog --title "Remove M0D from $modDIRtmpfs" --ok-label SELECT --cancel-label BACK --menu "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRtmpfs )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
    #selectFILE=$(readlink -f $(ls -1 $modDIRzips | sed -n "`echo "$FILE p" | sed 's/ //'`"))
	selectFILE=$(ls -1 $modDIRtmpfs | sed -n "`echo "$FILE p" | sed 's/ //'`")
	rm $modDIRtmpfs/$selectFILE
	#dialog --no-collapse --title "  M0D Removed: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h /dev/shm |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRtmpfs )\n"  25 75
	if [ "$(ls -1 $modDIRtmpfs)" == '' ]; then
		dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRtmpfs )\n"  25 75
		DMLmainMENU
	fi
	M0DremoveTMPFS
fi

DMLmainMENU
}

addonZIPmenuROMS()
{
tput reset
# =====================================

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
done < <( ls -1 $modDIRzips )
#done < <( find "$modDIRzips" -maxdepth 1 -type f -iname "*.zip" )
FILE=$(dialog --title "Select M0D from $modDIRzips" --ok-label SELECT --cancel-label BACK --menu "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRroms )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
    #selectFILE=$(readlink -f $(ls -1 $modDIRzips | sed -n "`echo "$FILE p" | sed 's/ //'`"))
	selectFILE=$(ls -1 $modDIRzips | sed -n "`echo "$FILE p" | sed 's/ //'`")
	if [[ "$selectFILE" == *".zip" ]] || [[ "$selectFILE" == *".ZIP" ]]; then
		unzip -qq -o $modDIRzips/$selectFILE -d $modDIRroms
	else
		cp $modDIRzips/$selectFILE $modDIRroms
	fi
	dialog --no-collapse --title "  M0D Added: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRroms )\n"  25 75
	addonZIPmenuROMS
fi

DMLmainMENU
}

M0DremoveROMS()
{
tput reset
# =====================================
if [ "$(ls -1 $modDIRroms)" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRroms )\n"  25 75
	DMLmainMENU
fi
	
let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
done < <( ls -1 $modDIRroms )
#done < <( find "$modDIRzips" -maxdepth 1 -type f -iname "*.zip" )
FILE=$(dialog --title "Remove M0D from $modDIRroms" --ok-label SELECT --cancel-label BACK --menu "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRroms )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
    #selectFILE=$(readlink -f $(ls -1 $modDIRzips | sed -n "`echo "$FILE p" | sed 's/ //'`"))
	selectFILE=$(ls -1 $modDIRroms | sed -n "`echo "$FILE p" | sed 's/ //'`")
	rm $modDIRroms/$selectFILE
	if [ "$(ls -1 $modDIRroms)" == '' ]; then
		dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $modDIRroms )\n"  25 75
		DMLmainMENU
	fi
	M0DremoveROMS
fi

DMLmainMENU
}

mainMENU

#cat /dev/null > /dev/shm/runcommand.log
tput reset
exit 0
