#!/usr/bin/env bash

# This script will behave differently depending on the location it is ran from  
# Running this Script from [/home/pi/RetroPie/retropiemenu] will access the BOTH the Installer + Mod Loader Menus  
# Running this Script from [/opt/retropie/configs/ports/doom] will access 0NLY the Mod Loader Menu  
# Automatic Install/Removal Provided in Main Installer Menu  

# Manual Install of the [lzdoom-dazi.sh] should be placed in:  
# /opt/retropie/configs/ports/doom/lzdoom-dazi.sh  

# Settings Flag File used with [runcommand-onstart] should be placed in:  
# /opt/retropie/configs/ports/doom/lzdoom-dazi.flag  

# [lzdoom-dazi.flag] Should Contain 0NLY a 1 or 0:  
# 1 = ON   0 = OFF  

# For Manual Install to [runcommand-onstart.sh] use this one-liner [echo] command:  
# echo "if [[ \"\$2\" == *\"lzdoom\"* ]] && [[ \"\$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.flag)\" == '1' ]]; then echo \"\$3\" > /dev/shm/runcommand.log && sudo /home/$USER/RetroPie-Setup/retropie_packages.sh retropiemenu launch \"/opt/retropie/configs/ports/doom/lzdoom-dazi.sh\" </dev/tty > /dev/tty; fi #For Use With [lzdoom-dazi] #Line Should be LAST" >> /dev/shm/runcommand-onstart.sh  

versionDAZI=202205
modDIRzips=~/RetroPie/roms/ports/doom/mods/
modDIRroms=~/RetroPie/roms/ports/doom/addon/
modDIRtmpfs=/dev/shm/addon/
doomDIRwads=~/RetroPie/roms/ports/doom
zdoomCFGrp=/opt/retropie/configs/ports/doom/lzdoom.ini
zdoomCFGroms=~/RetroPie/roms/ports/doom/lzdoom.ini

# Location of Script determines Menu Launched
MENUlaunchDOOM=BACK
if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then MENUlaunchDOOM="LAUNCH $(cat /dev/shm/runcommand.log | sed 's/.*\///')"; fi

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

daziHUDoff=$(
echo ""
echo '+--------------------------------------------------------------------+   '
echo '|      | /|  |  |            |         |     /|    |_| ..  ......... |   '
echo '|      | /|  |  |  2  3  4   |         |     /|    |_| ..  ......... |   '
echo '|      | ~|~ | %|            |         |     ~|~ % |_| ..  ......... |   '
echo '|      | /|  |  |            |         |     /|    |_| ..  ......... |   '
echo '| AMMO | HEALTH |  5  6  7   |         |    ARMOR  |#| ..  ......... |   '
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
echo " [doom] Port Config: /opt/retropie/configs/ports/emulators.cfg"
echo " [doom] Launch Scripts: ~/RetroPie/roms/ports/doom/*D00M*.sh"
echo " [doom] M0D Files: ~/RetroPie/roms/ports/doom/mods/*.zip/pk3/wad"
echo ""
)

zdoomCFGinis=$(
echo ""
echo " [ZDoom] Config Default: [$zdoomCFGrp]"
echo " [ZDoom] Config Roms: [$zdoomCFGroms]"
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
echo " #  HOW TO PRE-LOAD D00M M0Ds WITH [DAZI] FOR 0THER ROMs [0PTION 1]  #"
echo "      Select and Load a D00M-MOD using the [DAZI-Template.sh]"
echo "       PRESS [A] BUTTON TO CONFIGURE *(Before the ROM Loads)*"
echo "                     * [EXIT WITHOUT LAUNCHING] *"
echo "  The Last D00M-M0D Selected will Still be Loaded in [/dev/shm/addon]"
echo "  Now Select any 0ther Desired D00M R0M and Launch with [lzdoom-dazi]"
echo ""
echo " #  HOW TO PRE-LOAD D00M M0Ds WITH [DAZI] FOR 0THER ROMs [0PTION 2]  #"
echo "[dazi-mod-loader] is Included for use with [lzdoom-addon]/[lzdoom-dazi]"
echo "Use [dazi-mod-loader] from this Script directly, 0r Install it and..."
echo "Configure it to Always Load when [lzdoom-addon]/[lzdoom-dazi] Launches"
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
echo '# Define addonDIR - Default RetroPie or Default DAZI tmpfs'
echo '#addonDIR=~/RetroPie/roms/ports/doom/addon'
echo 'addonDIR=/dev/shm/addon'
echo ''
echo '# Display Loading Files by name'
echo "echo LOADING \$(echo \"\$modZIP\" | sed 's|.*/||' ) \$(echo \"\$optionalZIP\" | sed 's|.*/||' )"
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
echo 'if [ ! "$(cat /dev/shm/runcommand.log)" == "''" ]; then rm "$addonDIR" -R -f && mkdir "$addonDIR" > /dev/null 2>&1; fi'
echo ''
)

# This is a verified working lzdoom [emulators.cfg] file
# Pulled from a Rpi4 running RetroPie v4.8
lzdoomCFGemu=$(
echo "lzdoom = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 -config /home/$USER/RetroPie/roms/ports/doom/lzdoom.ini +vid_renderer 0 +'snd_mididevice -2' +vid_vsync 1 -width %XRES% -height %YRES%\""
echo 'default = "lzdoom"'
echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 -config /home/$USER/RetroPie/roms/ports/doom/lzdoom.ini +vid_renderer 0 +'snd_mididevice -2' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/$USER/RetroPie/roms/ports/doom/addon/*\""
echo "lzdoom-addon-320x200 = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 -config /home/$USER/RetroPie/roms/ports/doom/lzdoom.ini +vid_renderer 0 +'snd_mididevice -2' +vid_vsync 1 -width 320 -height 200 -file /home/$USER/RetroPie/roms/ports/doom/addon/*\""
)

daziEMUcfg=$(
echo ""
echo "           [DAZI] is intended for use with [lzdoom]... "
echo "         Recommended INSTALLING [lzdoom] FIRST... "
echo ""
echo 'If N0T a GENERIC lzdoom based [emulators.cfg] will be Genterated...'
echo "But you may experience Mixed Results with the GENERIC [emulators.cfg]"
)

symLINKSref=$(
echo ""
echo " SYMBOLIC LINKS for [doom.wads]:"
echo 'Use To Differentiate Which ZDoom AddOn Directory to Select via Emulator'
echo ""
echo 'The [lzdoom-dazi] Entry in [emulators.cfg] refers to [/dev/shm/addon/*]'
echo 'But LARGER M0Ds may EXCEED the Size Limitation of [/dev/shm/addon/*]'
echo 'We will want to use [lzdoom-addon] Emulator instead of [lzdoom-dazi]'
echo ""
echo "Normally we would just [Select Emulator for ROM] from the [runcommand]"
echo "But D00M M0Ds use the same [doom.wad] as the [ROM] repeatedly, meaning"
echo "[Select Emulator for ROM] will APPLY TO ALL M0Ds using that [doom.wad]"
echo ""
echo "We can Create Symbolic Links to [doom.wads] using Unique names, then..."
echo "Add [Unique.wads] into [LargeM0D.sh] scripts that need [lzdoom-addon]"
echo ""
echo ' eg. WADFile: [doom2.wad]  <->  SymbolicLink: [doom2-addon.wad]'
echo ' eg. LargeM0D.sh: [doomWAD=~/RetroPie/roms/ports/doom/doom2-addon.wad]'
echo ""
)

mainMENU()
{

# Update [symLINKSwads] when entering menu
symLINKSwads=$(
echo ""
echo "======================================================================"
echo "                    ~/RetroPie/roms/ports/doom/"
echo '===========[WADFile]=========================={SymbolicLink}=========='
echo "         freedoom1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom1-addon.wad )"
echo "         freedoom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom2-addon.wad )"
echo "         doom.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom-addon.wad )"
echo "         doom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom2-addon.wad | grep -v freedoom2 )"
echo "         doomu.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doomu-addon.wad )"
echo "         plutonia.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then echo "???"; fi)                       $(ls -1 ~/RetroPie/roms/ports/doom/ | grep plutonia-addon.wad )"
echo "         tnt.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep tnt-addon.wad )"
echo "         heretic.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep heretic-addon.wad )"
echo "         hexen.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hexen-addon.wad )"
echo "         strife1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep strife1-addon.wad )"
echo "======================================================================"
echo ""
)

# WARN IF [..ports/doom/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/doom/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "$daziEMUcfg"  25 75
fi
# Confirm Configurations
confCONFIG=$(dialog --stdout --no-collapse --title " D00M AddOn ZIP Integration [DAZI] for [lzdoom] by: RapidEdwin08 [$versionDAZI]" \
	--ok-label OK --cancel-label EXIT \
	--menu "$scriptREF" 25 75 20 \
	1 "><  [dazi-mod-loader]  ><" \
	2 "><  ENABLE  [dazi-mod-loader] at [runcommand]  ><" \
	3 "><  DISABLE [dazi-mod-loader] at [runcommand]  ><" \
	4 "><  REFERENCES  ><" \
	5 "><  INSTALL [lzdoom-dazi] + [dazi-mod-loader]  ><" \
	6 "><  GET [DAZI-Templates.sh] for [/roms/ports]   ><" \
	7 "><  MANAGE [SymbolicLinks] for [doom.wads]   ><" \
	8 "><  REMOVE  [lzdoom-dazi] + [dazi-mod-loader]  ><")

if [ "$confCONFIG" == '1' ]; then DMLmainMENU; fi 

# Turn DAZI @runcommand-onstart ON
if [ "$confCONFIG" == '2' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag ON [dazi-mod-loader]
		echo '1' > /opt/retropie/configs/ports/doom/lzdoom-dazi.flag
		dialog --no-collapse --title "ENABLE  [dazi-mod-loader] at [runcommand]  *COMPLETE!*" --ok-label Back --msgbox "ENABLED... \n$daziHUD"  25 75
	fi
mainMENU
fi

# Turn DAZI @runcommand-onstart OFF
if [ "$confCONFIG" == '3' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag OFF [dazi-mod-loader]
		echo '0' > /opt/retropie/configs/ports/doom/lzdoom-dazi.flag
		dialog --no-collapse --title "DISABLE  [dazi-mod-loader] at [runcommand]  *COMPLETE!*" --ok-label Back --msgbox "DISABLED... \n$daziHUDoff"  25 75
	fi
mainMENU
fi

# REFERENCES
if [ "$confCONFIG" == '4' ]; then
	dialog --no-collapse --title "[DAZI] for [RetroPie] REFERENCES" --ok-label Back --msgbox "$daziLOGO $zipREFmod $daziHUD $symLINKSref $symLINKSwads $daziFILES $zdoomCFGinis"  25 75
	mainMENU
fi

# INSTALL [lzdoom-dazi]
if [ "$confCONFIG" == '5' ]; then
	confINSTALLdazi=$(dialog --stdout --no-collapse --title "               INSTALL  [lzdoom-dazi] + [dazi-mod-loader]              " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  INSTALL  [lzdoom-dazi] + [dazi-mod-loader]  ><" \
		2 "><  BACK  ><")
	# Install Confirmed - Otherwise Back to Main Menu
	if [ "$confINSTALLdazi" == '1' ]; then installDAZI; fi
mainMENU
fi

# Get Templates
if [ "$confCONFIG" == '6' ]; then
	confGETdazi=$(dialog --stdout --no-collapse --title "               GET [DAZI-Templates.sh] for [/roms/ports]              " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  GET [DAZI-Templates.sh] for [/roms/ports]  ><" \
		2 "><  BACK  ><")
	# Confirmed - Otherwise Back to Main Menu
	if [ "$confGETdazi" == '1' ]; then getDAZIsh; fi
mainMENU
fi

# Create SymbolicLinks
if [ "$confCONFIG" == '7' ]; then symLINKSmenu; fi

# REMOVE [lzdoom-dazi]
if [ "$confCONFIG" == '8' ]; then
	confREMOVEdazi=$(dialog --stdout --no-collapse --title "               REMOVE  [lzdoom-dazi] + [dazi-mod-loader]              " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  REMOVE  [lzdoom-dazi] + [dazi-mod-loader]  ><" \
		2 "><  BACK  ><")
	# Uninstall Confirmed - Otherwise Back to Main Menu
	if [ "$confREMOVEdazi" == '1' ]; then removeDAZI; fi
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

symLINKSmenu()
{

# Update [symLINKSwads] when entering menu
symLINKSwads=$(
#echo ""
echo "======================================================================"
echo "                    ~/RetroPie/roms/ports/doom/"
echo '===========[WADFile]=========================={SymbolicLink}=========='
echo "         freedoom1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom1-addon.wad )"
echo "         freedoom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom2-addon.wad )"
echo "         doom.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom-addon.wad )"
echo "         doom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom2-addon.wad | grep -v freedoom2 )"
echo "         doomu.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doomu-addon.wad )"
echo "         plutonia.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then echo "???"; fi)                       $(ls -1 ~/RetroPie/roms/ports/doom/ | grep plutonia-addon.wad )"
echo "         tnt.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep tnt-addon.wad )"
echo "         heretic.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep heretic-addon.wad )"
echo "         hexen.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hexen-addon.wad )"
echo "         strife1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep strife1-addon.wad )"
echo "======================================================================"
echo ""
)

# Create SymbolicLinks
confLINKSdazi=$(dialog --stdout --no-collapse --title " CREATE [SymbolicLinks] for [doom.wads]: {ln -s doom.wad doom-symlink.wad}" \
	--ok-label OK --cancel-label BACK \
	--menu "$symLINKSwads" 25 75 20 \
	1 "><  CREATE [SymbolicLinks] for STANDARD [doom.wads]  ><" \
	2 "><  REMOVE [SymbolicLinks] for STANDARD [doom.wads]  ><" \
	3 "><  CREATE [SymbolicLinks] for 0THER [doom.wads]  ><" \
	4 "><  REMOVE [SymbolicLinks] for 0THER [doom.wads]  ><" \
	5 "><  REFERENCES for [SymbolicLinks]  ><" \
	6 "><  BACK  ><")
# Confirmed - Otherwise Back to Main Menu
if [ "$confLINKSdazi" == '1' ]; then symLINKSaddon; fi
if [ "$confLINKSdazi" == '2' ]; then symLINKSremove; fi
if [ "$confLINKSdazi" == '3' ]; then ADDsymLINKSwadUSER; fi
if [ "$confLINKSdazi" == '4' ]; then REMOVEsymLINKSwadUSER; fi

# REFERENCES for SymbolicLinks
if [ "$confLINKSdazi" == '5' ]; then
	dialog --no-collapse --title "[SymbolicLinks] for [doom.wads] REFERENCES" --ok-label Back --msgbox "$symLINKSref $symLINKSwads $(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )"  25 75
	symLINKSmenu
fi
mainMENU
}

ADDsymLINKSwadUSER()
{
tput reset
# =====================================
if [ "$(find $doomDIRwads -maxdepth 1 -type f | sed 's|.*/||' | sort -n )" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] \n"  25 75
	symLINKSmenu
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
#done < <( ls -1 $doomDIRwads )
done < <( find "$doomDIRwads" -maxdepth 1 -type f | sed 's|.*/||' | sort -n )
FILE=$(dialog --title "Select WAD from $doomDIRwads" --ok-label SELECT --cancel-label BACK --menu "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $doomDIRwads -maxdepth 1 -type f | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	if [[ "$selectFILE" == *".wad" ]] || [[ "$selectFILE" == *".WAD" ]]; then
		userWADlink="$(echo $selectFILE | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' )-addon.wad"
		rm "$doomDIRwads/$userWADlink" 2>/dev/null
		ln -s "$doomDIRwads/$selectFILE" "$doomDIRwads/$userWADlink"
	else
		dialog --no-collapse --title "  NOT A WAD FILE: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )]\n \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
		ADDsymLINKSwadUSER
	fi
	dialog --no-collapse --title "  SYMBOLIC LINK to WAD Added: [$selectFILE] <-> [$userWADlink]  " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )]\n  \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
	ADDsymLINKSwadUSER
fi

symLINKSmenu
}

REMOVEsymLINKSwadUSER()
{
tput reset
# =====================================
if [ "$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
	symLINKSmenu
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
#done < <( ls -1 $doomDIRwads )
done < <( find "$doomDIRwads" -maxdepth 1 -type l | sed 's|.*/||' | sort -n )
FILE=$(dialog --title "Select WAD from $doomDIRwads" --ok-label SELECT --cancel-label BACK --menu "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] \n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	if [[ "$selectFILE" == *".wad" ]] || [[ "$selectFILE" == *".WAD" ]]; then
		rm "$doomDIRwads/$selectFILE" 2>/dev/null
		# dialog --no-collapse --title "  SYMBOLIC LINK REMOVED: [$selectFILE] " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )]\n  \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
		REMOVEsymLINKSwadUSER
	else
		dialog --no-collapse --title "  NOT A WAD FILE: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )]\n \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
		REMOVEsymLINKSwadUSER
	fi
fi

symLINKSmenu
}

removeDAZI()
{
tput reset

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

# Remove [zdoom-dazi.sh]
rm /opt/retropie/configs/ports/doom/lzdoom-dazi.sh 2>/dev/null
rm /opt/retropie/configs/ports/doom/lzdoom-dazi.flag 2>/dev/null

dialog --no-collapse --title "REMOVE [DAZI] for [RetroPie]  *COMPLETE!*" --ok-label Back --msgbox "$daziLOGO $daziFILES"  25 75

mainMENU
}

installDAZI()
{
tput reset
# =====================================
# Install [ZIP/UNZIP] - Check If Internet Connection Available
if [[ "$(dpkg -l | grep -F '  zip ')" == '' ]] || [[ "$(dpkg -l | grep -F '  unzip ')" == '' ]]; then
	wget -q --spider http://google.com
	if [ $? -eq 0 ]; then
		sudo apt-get install zip
		sudo apt-get install unzip
	else
		# No Internet - Back to Main Menu
		dialog --no-collapse --title "               [ERROR]               " --msgbox "   *INTERNET CONNECTION REQUIRED* TO INSTALL [ZIP/UNZIP]"  25 75
		mainMENU
	fi
fi

# Create [emulators.cfg] from a verified working [emulators.cfg] file If N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then echo "$lzdoomCFGemu" > /opt/retropie/configs/ports/doom/emulators.cfg; fi

# Backup emulators.cfg if not exist already
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi ]; then cp /opt/retropie/configs/ports/doom/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi 2>/dev/null; fi

# Add [dazi] to [emulators.cfg]
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -v 'lzdoom-dazi-' | grep -v 'lzdoom-dazi =' > /dev/shm/emulators.cfg
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep 'lzdoom-addon' > /dev/shm/emulators.dazi
if [ "$(cat /dev/shm/emulators.dazi | grep -q 'lzdoom-addon =' ; echo $?)" == '1' ]; then
	echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 -config /home/$USER/RetroPie/roms/ports/doom/lzdoom.ini +vid_renderer 0 +'snd_mididevice -2' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/$USER/RetroPie/roms/ports/doom/addon/*\"" > /dev/shm/emulators.dazi
	echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 -config /home/$USER/RetroPie/roms/ports/doom/lzdoom.ini +vid_renderer 0 +'snd_mididevice -2' +vid_vsync 1 -width %XRES% -height %YRES% -file /home/$USER/RetroPie/roms/ports/doom/addon/*\"" >> /dev/shm/emulators.cfg
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
	echo "if [[ \"\$2\" == *\"lzdoom\"* ]] && [[ \"\$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.flag)\" == '1' ]]; then echo \"\$3\" > /dev/shm/runcommand.log && sudo /home/$USER/RetroPie-Setup/retropie_packages.sh retropiemenu launch \"/opt/retropie/configs/ports/doom/lzdoom-dazi.sh\" </dev/tty > /dev/tty; fi #For Use With [lzdoom-dazi] #Line Should be LAST" >> /dev/shm/runcommand-onstart.sh
	mv /dev/shm/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh
fi

# This script will behave differently depending on the location - copy itself to install location
cp "$0" /dev/shm/
mv /dev/shm/lzdoom-dazi.sh /opt/retropie/configs/ports/doom/lzdoom-dazi.sh
sudo chmod 755 /opt/retropie/configs/ports/doom/lzdoom-dazi.sh

# Toggle [runcommand] Flag ON [dazi-mod-loader]
echo '1' > /opt/retropie/configs/ports/doom/lzdoom-dazi.flag

# FINISHED
dialog --no-collapse --title "INSTALL [DAZI] for [RetroPie]  *COMPLETE!* " --ok-label Back --msgbox "$daziLOGO $zipREFmod $daziHUD $symLINKSref $symLINKSwads $daziFILES"  25 75

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

# ADDON Templates
if [ -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then
	rm ~/RetroPie/roms/ports/doom/freedoom1-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom1.wad ~/RetroPie/roms/ports/doom/freedoom1-addon.wad 2>/dev/null
	echo "$daziSH" > ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(ADDON\).sh
	sed -i 's/doom1.wad/freedoom1-addon.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(ADDON\).sh
	sed -i 's+#addonDIR=~/RetroPie/roms/ports/doom/addon+addonDIR=~/RetroPie/roms/ports/doom/addon+g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(ADDON\).sh
	sed -i 's+addonDIR=/dev/shm/addon+#addonDIR=/dev/shm/addon+g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(ADDON\).sh
fi

if [ -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then
	rm ~/RetroPie/roms/ports/doom/freedoom2-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom2.wad ~/RetroPie/roms/ports/doom/freedoom2-addon.wad 2>/dev/null
	echo "$daziSH" > ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(ADDON\).sh
	sed -i 's/doom1.wad/freedoom2-addon.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(ADDON\).sh
	sed -i 's+#addonDIR=~/RetroPie/roms/ports/doom/addon+addonDIR=~/RetroPie/roms/ports/doom/addon+g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(ADDON\).sh
	sed -i 's+addonDIR=/dev/shm/addon+#addonDIR=/dev/shm/addon+g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(ADDON\).sh
fi

# Get SIGIL If Internet Connection Available
wget -q --spider http://google.com
if [ $? -eq 0 ]; then	
	if [[ "$(dpkg -l | grep -F '  zip ')" == '' ]] || [[ "$(dpkg -l | grep -F '  unzip ')" == '' ]]; then
		sudo apt-get install zip
		sudo apt-get install unzip
	fi
	wget --progress=bar:force https://romero.com/s/SIGIL_v1_21.zip -P /dev/shm
	unzip -qq -o /dev/shm/SIGIL_v1_21.zip -d /dev/shm
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
dialog --no-collapse --title "GET [DAZI-Templates.sh] for [../roms/ports] *COMPLETE!* " --ok-label Back --msgbox "$daziLOGO $daziFILES"  25 75

mainMENU
}

DMLmainMENU()
{
if [ ! -d $modDIRtmpfs ]; then mkdir $modDIRtmpfs; fi
if [ ! -d $modDIRroms ]; then mkdir $modDIRroms; fi
if [ ! -d $modDIRzips ]; then mkdir $modDIRzips; fi

# WARN IF [..ports/doom/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/doom/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "MAKE SURE LZDOOM IS INSTALLED!"  25 75
fi
# Confirm Configurations
DMLconfCONFIG=$(dialog --stdout --no-collapse --title " [DAZI] M0D LOADER for [lzdoom] by: RapidEdwin08 [$versionDAZI]" \
	--ok-label SELECT --cancel-label "$MENUlaunchDOOM" \
	--menu "\n[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n ) \n$daziHUD \n[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n ) \n" 25 75 20 \
	1 ">< $MENUlaunchDOOM ><" \
	2 ">< LOAD   [M0D] in [$modDIRtmpfs] (tmpfs) ><" \
	3 ">< REMOVE [M0D] in [$modDIRtmpfs] (tmpfs) ><" \
	4 ">< LOAD   [M0D] in [$modDIRroms] ><" \
	5 ">< REMOVE [M0D] in [$modDIRroms] ><" \
	6 ">< DELETE [lzdoom.ini] Configuration (RESET) ><")

if [ "$DMLconfCONFIG" == '1' ]; then
	if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then
		cat /dev/null > /dev/shm/runcommand.log
		tput reset
		exit 0
	else
		mainMENU
	fi
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
		rm "$zdoomCFGrp"
		rm "$zdoomCFGroms"
		dialog --no-collapse --title "DELETE [lzdoom.ini] Configuration (RESET) *COMPLETE!*" --ok-label Back --msgbox "Default: [$zdoomCFGrp]  \nPorts:   [$zdoomCFGroms]\n"  25 75
		DMLmainMENU
	fi
DMLmainMENU
fi

# Back if N0T Confirmed
if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then
	cat /dev/null > /dev/shm/runcommand.log
	exit 0
fi

tput reset
mainMENU
}

addonZIPmenuTMPFS()
{
tput reset
# =====================================
if [ "$(find $modDIRzips -maxdepth 1 -type f | sed 's|.*/||' | sort -n )" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRzips] FreeSpace: [$(df -h $modDIRzips |awk '{print $4}' | grep -v Avail )] \n"  25 75
	DMLmainMENU
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
#done < <( ls -1 $modDIRzips )
done < <( find "$modDIRzips" -maxdepth 1 -type f | sed 's|.*/||' | sort -n )
FILE=$(dialog --title "Select M0D from $modDIRzips" --ok-label SELECT --cancel-label BACK --menu "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $modDIRzips -maxdepth 1 -type f | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	if [[ "$selectFILE" == *".zip" ]] || [[ "$selectFILE" == *".ZIP" ]]; then
		unzip -qq -o "$modDIRzips/$selectFILE" -d $modDIRtmpfs
	else
		cp "$modDIRzips/$selectFILE" $modDIRtmpfs
	fi
	dialog --no-collapse --title "  M0D Added: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h /dev/shm |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n )\n"  25 75
	addonZIPmenuTMPFS
fi

DMLmainMENU
}

M0DremoveTMPFS()
{
tput reset
# =====================================
if [ "$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n )" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n"  25 75
	DMLmainMENU
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
#done < <( ls -1 $modDIRtmpfs )
done < <( find "$modDIRtmpfs" -maxdepth 1 -type f | sed 's|.*/||' | sort -n )
FILE=$(dialog --title "Remove M0D from $modDIRtmpfs" --ok-label SELECT --cancel-label BACK --menu "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	rm "$modDIRtmpfs/$selectFILE"
	if [ "$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n )" == '' ]; then
		dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n"  25 75
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
if [ "$(find $modDIRzips -maxdepth 1 -type f | sed 's|.*/||' | sort -n )" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRzips] FreeSpace: [$(df -h $modDIRzips |awk '{print $4}' | grep -v Avail )] \n"  25 75
	DMLmainMENU
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
#done < <( ls -1 $modDIRzips )
done < <( find "$modDIRzips" -maxdepth 1 -type f | sed 's|.*/||' | sort -n )
FILE=$(dialog --title "Select M0D from $modDIRzips" --ok-label SELECT --cancel-label BACK --menu "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $modDIRzips -maxdepth 1 -type f | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	if [[ "$selectFILE" == *".zip" ]] || [[ "$selectFILE" == *".ZIP" ]]; then
		unzip -qq -o "$modDIRzips/$selectFILE" -d $modDIRroms
	else
		cp "$modDIRzips/$selectFILE" $modDIRroms
	fi
	dialog --no-collapse --title "  M0D Added: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n )\n"  25 75
	addonZIPmenuROMS
fi

DMLmainMENU
}

M0DremoveROMS()
{
tput reset
# =====================================
if [ "$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n )" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n"  25 75
	DMLmainMENU
fi
	
let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
#done < <( ls -1 $modDIRroms )
done < <( find "$modDIRroms" -maxdepth 1 -type f | sed 's|.*/||' | sort -n )
FILE=$(dialog --title "Remove M0D from $modDIRroms" --ok-label SELECT --cancel-label BACK --menu "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	rm "$modDIRroms/$selectFILE"
	if [ "$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n )" == '' ]; then
		dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n"  25 75
		DMLmainMENU
	fi
	M0DremoveROMS
fi

DMLmainMENU
}

symLINKSaddon()
{
tput reset

# Check for Main [doom.wad] Files - Create Symbolic Links If Found
if [ -f ~/RetroPie/roms/ports/doom/doom.wad ]; then
	rm ~/RetroPie/roms/ports/doom/doom-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doom.wad ~/RetroPie/roms/ports/doom/doom-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then
	rm ~/RetroPie/roms/ports/doom/doom2-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doom2.wad ~/RetroPie/roms/ports/doom/doom2-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then
	rm ~/RetroPie/roms/ports/doom/doomu-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doomu.wad ~/RetroPie/roms/ports/doom/doomu-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then
	rm ~/RetroPie/roms/ports/doom/freedoom1-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom1.wad ~/RetroPie/roms/ports/doom/freedoom1-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then
	rm ~/RetroPie/roms/ports/doom/freedoom2-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom2.wad ~/RetroPie/roms/ports/doom/freedoom2-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then
	rm ~/RetroPie/roms/ports/doom/plutonia-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/plutonia.wad ~/RetroPie/roms/ports/doom/plutonia-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then
	rm ~/RetroPie/roms/ports/doom/tnt-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/tnt.wad ~/RetroPie/roms/ports/doom/tnt-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then
	rm ~/RetroPie/roms/ports/doom/heretic-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/heretic.wad ~/RetroPie/roms/ports/doom/heretic-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then
	rm ~/RetroPie/roms/ports/doom/hexen-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/hexen.wad ~/RetroPie/roms/ports/doom/hexen-addon.wad 2>/dev/null
fi

if [ -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then
	rm ~/RetroPie/roms/ports/doom/strife1-addon.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/strife1.wad ~/RetroPie/roms/ports/doom/strife1-addon.wad 2>/dev/null
fi

# Update [symLINKSwads] when entering menu
symLINKSwads=$(
#echo ""
echo "======================================================================"
echo "                    ~/RetroPie/roms/ports/doom/"
echo '===========[WADFile]=========================={SymbolicLink}=========='
echo "         freedoom1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom1-addon.wad )"
echo "         freedoom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom2-addon.wad )"
echo "         doom.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom-addon.wad )"
echo "         doom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom2-addon.wad | grep -v freedoom2 )"
echo "         doomu.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doomu-addon.wad )"
echo "         plutonia.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then echo "???"; fi)                       $(ls -1 ~/RetroPie/roms/ports/doom/ | grep plutonia-addon.wad )"
echo "         tnt.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep tnt-addon.wad )"
echo "         heretic.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep heretic-addon.wad )"
echo "         hexen.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hexen-addon.wad )"
echo "         strife1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep strife1-addon.wad )"
echo "======================================================================"
echo ""
)

# FINISHED
dialog --no-collapse --title "CREATE [SymbolicLinks] for STANDARD [doom.wads] *COMPLETE!* " --ok-label Back --msgbox "$symLINKSwads $daziHUD"  25 75

symLINKSmenu
}

symLINKSremove()
{
tput reset

# REMOVE Symbolic Links
rm ~/RetroPie/roms/ports/doom/freedoom1-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/freedoom2-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doom-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doom2-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doomu-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/plutonia-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/tnt-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/heretic-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/hexen-addon.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/strife1-addon.wad 2>/dev/null

# Update [symLINKSwads] when entering menu
symLINKSwads=$(
#echo ""
echo "======================================================================"
echo "                    ~/RetroPie/roms/ports/doom/"
echo '===========[WADFile]=========================={SymbolicLink}=========='
echo "         freedoom1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom1-addon.wad )"
echo "         freedoom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom2-addon.wad )"
echo "         doom.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom-addon.wad )"
echo "         doom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom2-addon.wad | grep -v freedoom2 )"
echo "         doomu.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doomu-addon.wad )"
echo "         plutonia.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then echo "???"; fi)                       $(ls -1 ~/RetroPie/roms/ports/doom/ | grep plutonia-addon.wad )"
echo "         tnt.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep tnt-addon.wad )"
echo "         heretic.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep heretic-addon.wad )"
echo "         hexen.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hexen-addon.wad )"
echo "         strife1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep strife1-addon.wad )"
echo "======================================================================"
echo ""
)

# FINISHED
dialog --no-collapse --title "REMOVE [SymbolicLinks]  for STANDARD [doom.wads] *COMPLETE!* " --ok-label Back --msgbox "$symLINKSwads $daziHUD"  25 75

symLINKSmenu
}

# Location of Script determines Menu Launched
if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then
	DMLmainMENU
else
	mainMENU
fi

if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then cat /dev/null > /dev/shm/runcommand.log; fi
tput reset
exit 0
