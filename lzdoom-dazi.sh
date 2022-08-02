#!/usr/bin/env bash

# IF DEFINED [alternateM0Ddir] will 0verride DEFAULT M0D Directory - DO NOT INCLUDE '/' at END of PATHs - DO NOT USE *R00T* '/' 0NLY
alternateM0Ddir=

# This script will behave differently depending on the location it is ran from  
# Running this Script from [/opt/retropie/configs/ports/doom] will access 0NLY the Mod Loader Menu  
# Running this Script from any 0THER Location will access the BOTH the Installer + Mod Loader Menus  
# Automatic Install/Removal Provided in Main Installer Menu  

# Manual Install of the [lzdoom-dazi.sh] should be placed in:  
# /opt/retropie/configs/ports/doom/lzdoom-dazi.sh  

# Settings Flag File used with [runcommand-onstart] should be placed in:  
# /opt/retropie/configs/ports/doom/lzdoom-dazi.flag  

# [lzdoom-dazi.flag] Should Contain 0NLY a 1 or 0:  
# 1 = ON   0 = OFF  

# For Manual Install to [runcommand-onstart.sh] use this one-liner [echo] command:  
# echo "if [[ \"\$1\" == \"doom\" ]] && [[ \"\$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.flag)\" == '1' ]]; then cat /dev/null > /dev/shm/runcommand.log && sudo /home/$USER/RetroPie-Setup/retropie_packages.sh retropiemenu launch \"/opt/retropie/configs/ports/doom/lzdoom-dazi.sh\" </dev/tty > /dev/tty; fi #For Use With [lzdoom-dazi] #Line Should be LAST" >> /opt/retropie/configs/all/runcommand-onstart.sh  

# Settings Clean File used with [runcommand-onend] should be placed in:  
# /opt/retropie/configs/ports/doom/lzdoom-dazi.clean  

# [lzdoom-dazi.clean] Should Contain 0NLY a 0 or 1 or 2 or 3:  
# 0 = OFF  1 = Clean TMPFS  2 = Clean ADDON  3 = Clean TMPFS+ADDON

# For Manual Install to [runcommand-onend.sh] use this one-liner [echo] command:  
#echo 'if [ "$(head -1 /dev/shm/runcommand.info)" == "doom" ]; then bash /opt/retropie/configs/ports/doom/lzdoom-dazi.sh clean; fi & #For Use With [lzdoom-dazi] #Line can be LAST' >> /opt/retropie/configs/all/runcommand-onend.sh  

versionDAZI=2022.08
M0DdirMAIN=~/RetroPie/roms/ports/doom/mods
modDIRroms=~/RetroPie/roms/ports/doom/addon
modDIRtmpfs=/dev/shm/addon
doomDIRwads=~/RetroPie/roms/ports/doom
zdoomCFGrp=/opt/retropie/configs/ports/doom/lzdoom.ini
zdoomCFGroms=~/RetroPie/roms/ports/doom/lzdoom.ini

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

daziHUDsrb2=$(
echo ""
echo '+--------------------------------------------------------------------+   '
echo '|      | /|  |  |       |       ___------__   |  /|   |_|. ......... |   '
echo '|      | /|  |  |       | |\__-- /\       _-  |  /|   |_|. ......... |   '
echo '|      | /|  |  |       | |/    __      -     |  /|   |_|. ~/....... |   '
echo '|      | /|  |  | 2 3 4 | //\  /  \    /__    |  /|   |_|. ./srb2... |   '
echo '|      | ~|~ | %|       | |  o|  0|__     --_ |  ~|~ %|_|. ...addons |   '
echo '|      | /|  |  |       | \\____-- __ \   ___-|  /|   |_|. ./srb2kart|   '
echo '|      | /|  |  |       | (@@    __/  / /_    |  /|   |_|. ~/....... |   '
echo '| AMMO | HEALTH | 5 6 7 |    -_____---   --_  | ARMOR |#|. ......... |   '
echo '+--------------------------------------------------------------------+   '
)

doomWARPdiff=$(
echo "======================================================================"
echo '          ~ ZDoom [Episode] [Map] [Difficulty] Settings ~ '
echo 'DAZI will Stream-Edit [emulators.cfg] to APPLY [-warp -skill ] Settings'
echo '*REQUIRES* [lzdoom-dazi+warp] or an ENTRY ENDING in -warp # # -skill #"'
echo ""
echo '===Standard Doom Difficulty==============Heretic Difficulty======'
echo '   1  Im too young to die             1  Thou needeth a wet-nurse'
echo '   2  Hey, not too rough              2  Yellowbellies-r-us'
echo '   3  Hurt me plenty                  3  Bringest them oneth'
echo '   4  Ultra-Violence                  4  Thou art a smite-meister'
echo '   5  Nightmare!                      5  Black plague possesses thee'
echo ""
echo '==== Warp+Difficulty Examples ========= [-warp E# M# -skill S#] ===='
echo '[-warp 5 9 -skill 4] Ultimate Doom SIGIL E5M9 on Ultra-Violence'
echo '[-warp 6 1 -skill 1] Heretic FatesPath E6M1 on Thou Needeth a Wet-Nurse'
echo '[-warp 2 1 -skill 3] Ultimate Doom AliensTC E2M1 on Hurt me plenty'
echo '[-warp  31 -skill 5] Doom II SecretWolfensteinLevel MAP31 on Nightmare!'
echo '       NOTE: Leave [Episode] set to [NONE] for D00M II Maps'
echo "======================================================================"
echo " CURRENT [doom] Port Config: /opt/retropie/configs/ports/emulators.cfg"
)

scriptREF=$(
echo ""
#echo '- LZDOOM:'
echo '[lzdoom-addon] Loads M0Ds from ADDON [..roms/ports/doom/addon/*]'
echo '[lzdoom-dazi]  Loads M0Ds from TMPFS [/dev/shm/addon/*]'
echo '[lzdoom-dazi+] Loads M0Ds from BOTH  [TMPFS+ADDON] in that 0rder'
echo '[lzdoom-dazi+warp] Loads from [TMPFS+ADDON] and Includes [-WARP -SKILL]'
echo ''
echo "- HOW TO LOAD M0Ds:"
echo 'Place [D00M-M0D] FILEs [WAD/PK3/PK7/ZIPs] in [..roms/ports/doom/mods/*]'
echo "Use [dazi-mod-loader] to Load M0Ds for [lzdoom-addon] or [lzdoom-dazi]"
echo "Alternatively use runcommand [Exit-Without-Launching] to Pre-Load M0Ds"
echo ""
echo "- HOW CREATE ROM ENTRIES FOR D00M M0Ds:"
echo 'Create a [D00M-M0D.sh] based on a [DAZI-Template.sh] in [/roms/ports]'
echo 'ADD [doomMOD#s] to [D00M-M0D.sh] and MODIFY [addonDIR] if needed'
echo 'RUN [lzdoom-dazi] or [lzdoom-addon] based on the [D00M-M0D.sh] addonDIR'
)

daziFILES=$(
echo ""
echo " [doom] Port Config: /opt/retropie/configs/ports/emulators.cfg"
echo " [doom] Launch Scripts: ~/RetroPie/roms/ports/doom/*D00M*.sh"
echo " [doom] M0D Files: ~/RetroPie/roms/ports/doom/mods/*.zip/pk3/pk7/wad"
echo ""
)

srb2FILES=$(
echo ""
echo "======================================================================"
echo " [srb2] Configs: [/opt/retropie/configs/ports/srb2/config.cfg]"
echo "               : [/opt/retropie/configs/ports/srb2kart/kartconfig.cfg]"
echo ""
echo " [srb2] AddOns DEFAULT: [/opt/retropie/configs/ports/srb2/addons]"
echo "                      : [/opt/retropie/configs/ports/srb2kart/addons]"
echo "                      : [/opt/retropie/configs/ports/srb2kart/DOWNLOAD]"
echo ""
echo " [srb2] AddOns D00M M0Ds: [~/RetroPie/roms/ports/doom/mods/srb2]"
echo "                        : [~/RetroPie/roms/ports/doom/mods/srb2kart]"
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
echo '                             # * TIPs * #'
echo ' AVOID using [S P A C E S] and [$PEC!AL CH@RACT€R$] in your M0D NAMEs'
echo ""
echo 'Some M0Ds already come as [ZIP] since ZDoom supports Loading [ZIP] but,'
echo 'You can RENAME [ZIP] -> [pk3] if you want to Ignore Extraction by DAZI'
echo '       eg.  [strayDoom.v01.zip]  ->  [strayDoom_v01.pk3]'
echo ""
echo ' [ipk3] files typically do not Require you to Load a Main [iwad] but,'
echo 'You can RENAME [ipk3] -> [pk3] and load a [fakeiwad.wad] or [doom2.wad]'
echo ""
echo ' [pk3/pk7] are Compressed Files Already, NO NEED to ZIP Individually'
echo ' [WADs] can be Compressed, but can take time to Extract if LARGE'
echo 'LARGE [WADs] might EXCEED the Size of [/dev/shm/] (tmpfs) on some HW'
echo ""
echo ' [ZIPs] are good to use with Individual MAPs/MEGAWADs to Save Space'
echo ' ADD Numeric 0rder to the NAME(s) before Compressing MAPs/MEGAWADs'
echo ' eg. [aaliens.wad] 135MB -> (01_aaliens.wad) -> [aaliens.zip] 37MB'
echo ""
echo ' [ZIPs] are good to use with Smaller M0Ds that have lots of files'
echo ' eg. The 0riginal [AliensTC] is Small and has numerous files to Load'
echo ""
echo "        # PLACE YOUR [D00M-M0D] FILES INTO A [D00M-M0D.ZIP] #"
echo "    NAME THEM ACCORDINGLY IF A PARTICULAR L0ADING 0RDER IS NEEDED"
echo ""
echo '                # EXAMPLE [D00M-M0D.ZIP] CONTENTS #'
echo '                 ./D00M-M0D.ZIP/01_FileToLoad.wad'
echo '                 ./D00M-M0D.ZIP/02_FileToLoad.pk3'
echo '                 ./D00M-M0D.ZIP/03_FileToLoad.pk7'
echo ''
echo " # MODIFY [DAZI-Template.sh] TO INCLUDE YOUR [doomWAD] + [doomMOD#s] #"
echo '  * Use FULL PATHs and AVOID SPACES for your [doomWAD] + [doomMOD#s] *'
echo ""
echo '              # EXAMPLE [DAZI-Template.sh] CONTENTS #'
echo '          doomWAD=~/RetroPie/roms/ports/doom/doom2.wad'
echo '      doomMOD1=~/RetroPie/roms/ports/doom/mods/brutalv21.pk3'
echo ' doomMOD2=~/RetroPie/roms/ports/doom/mods/hellonearthstarterpack.wad'
echo ""
echo "  #  HOW TO PRE-LOAD D00M M0Ds using the [Runcommand Launch Menu]:  #"
echo "      Select and Load a D00M-MOD using the [DAZI-Template.sh]"
echo "       PRESS [A] BUTTON TO CONFIGURE *(Before the ROM Loads)*"
echo "                     * [EXIT WITHOUT LAUNCHING] *"
echo "  The Last D00M-M0D Selected will Still be Loaded in [/dev/shm/addon]"
echo "  Now Select any 0ther Desired D00M R0M and Launch with [lzdoom-dazi]"
echo "           Or Repeat the Process to Pre-Load more D00M-M0Ds"
echo ""
echo "  #  HOW TO PRE-LOAD D00M M0Ds using the [dazi-mod-loader] MENU:  #"
echo "[dazi-mod-loader] is Included for use with [lzdoom-addon]/[lzdoom-dazi]"
echo "Use [dazi-mod-loader] from this Script directly, 0r Install it and..."
echo "Configure it to Always Load when the [doom] P0RT Launches"
echo ""
)

daziSH=$(
#echo '#!/bin/bash'
echo "# https://github.com/RapidEdwin08/dazi  #v$versionDAZI"
echo ''
echo '# Define [D00M.WAD] - /full/path/to/doom.wad'
echo 'doomWAD=~/RetroPie/roms/ports/doom/doom1.wad'
echo ''
echo '# 0ptional Define As Many [doomMOD#s] As Needed Starting with #1 - Ascending Numeric 0rder'
echo 'doomMOD1='
echo ''
echo '# 0ptional WARP and DIFFICULTY Settings - Leave episodeNUM= *BLANK* For Doom II MAPs - eg. Doom II MAP31 Nightmare! -> episodeNUM= mapNUM=31 skillLEVEL=5'
echo 'episodeNUM=1993'
echo 'mapNUM=1993'
echo 'skillLEVEL=1993'
echo ''
echo '# Define addonDIR - dazi TMPFS - Default RetroPie ADDON'
echo 'addonDIR=/dev/shm/addon'
echo '#addonDIR=~/RetroPie/roms/ports/doom/addon'
echo ''
echo '# =========================================='
echo 'loadM0Ds() # Scripted L00P Supports Loading Any Number of [doomMOD#s] when Defined'
echo '{'
echo '# Prepare [doomMOD#s] IF DEFINED - ZIPs are Extracted to [addonDIR] - Symbolic LInks created for ALL 0THER File Types - Numeric 0rder Dynamically updated'
echo 'if [[ ! "${!rollingM0D}" == "" ]]; then if [[ "${!rollingM0D}" == *".zip" ]] || [[ "${!rollingM0D}" == *".ZIP" ]]; then unzip -qq -o "${!rollingM0D}" -d "$addonDIR" > /dev/null 2>&1; else ln -s "${!rollingM0D}" "$addonDIR/0${addonDIRcount}_$(basename "${!rollingM0D}" )"; fi; fi > /dev/null 2>&1'
echo 'count=$(( $count + 1 )) # Increase count by+1'
echo 'rollingM0D="doomMOD${count}" # Apply Increased count to [doomMOD#]'
echo 'if [[ ! "${!rollingM0D}" == "" ]]; then addonDIRcount=$(( $addonDIRcount + 1 )) && loadM0Ds; fi # Prepare more [doomMOD#s] IF DEFINED'
echo '}'
echo ''
echo '# Prepare WARP and DIFFICULTY Settings For [lzdoom-dazi+warp] - 0nly Update [-warp*] IF the Parameters are DEFINED - Set DEFAULT DIFFICULTY [Hurt me plenty] if NOT DEFINED - Update [-warp*] in [emulators.cfg]'
echo 'if [ ! "$episodeNUM" == "" ] || [ ! "$mapNUM" == "" ]; then if [ "$skillLEVEL" == "" ]; then skillLEVEL=3; fi; sed -i "s/-warp.*/-warp\ $episodeNUM\ $mapNUM\ -skill\ $skillLEVEL\"/g" /opt/retropie/configs/ports/doom/emulators.cfg; fi'
echo ''
echo 'mkdir "$addonDIR" > /dev/null 2>&1 # Prepare addonDIR'
echo 'count=1 # Set Initial Count'
echo 'rollingM0D="doomMOD${count}"'
echo 'if [ ! "$(find $addonDIR -maxdepth 1 -type f | wc -l )" == '0' ] || [ ! "$(find $addonDIR -maxdepth 1 -type l | wc -l )" == '0' ]; then addonDIRcount=$(( $count + $(find $addonDIR -maxdepth 1 -type f | wc -l ) + $(find $addonDIR -maxdepth 1 -type l | wc -l ) )); else addonDIRcount=$count; fi # Count Current Files/Links in ADDONS - Update addonDIRcount'
echo 'loadM0Ds # Load D00M M0Ds in Numeric 0rder'
echo '# =========================================='
echo ''
echo '# RUN D00M P0RT'
echo '"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "doom" "${doomWAD}"'
echo ''
)

# This is a verified working lzdoom [emulators.cfg] file
# Pulled from a Rpi3 running RetroPie v4.8
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
echo 'If N0T a GENERIC lzdoom based [emulators.cfg] may be Genterated...'
echo "But you may experience Mixed Results with the GENERIC [emulators.cfg]"
)

symLINKSref=$(
echo ""
echo '                # SYMBOLIC LINKS for [doom.wads]: #'
#echo 'Use To Differentiate Which ZDoom Emulator to Select for ROMs like +warp'
#echo ""
echo 'The [lzdoom-dazi+warp] Entry in [emulators.cfg] Includes [-WARP -SKILL]'
echo '  We may want to Differentiate the +warp Emulator for Certain ROMs'
echo ""
echo "Normally we would just [Select Emulator for ROM] from the [runcommand]"
echo "But D00M M0Ds use the same [doom.wad] as the [ROM] repeatedly, meaning"
echo "[Select Emulator for ROM] will APPLY TO ALL M0Ds using that [doom.wad]"
echo ""
echo "We can Create Symbolic Links to [doom.wads] using Unique names, then..."
echo "Use [SymbolicLink.wad] in [doom-warp.sh] scripts for [lzdoom-dazi+warp]"
echo ""
echo ' eg. WADFile: [doomu.wad]  <->  SymbolicLink: [doomu-warp.wad]'
echo 'eg. doomu-warp.sh: [doomWAD=~/RetroPie/roms/ports/doom/doomu-warp.wad]'
echo ""
)

# Location of Script determines Menu Launched
MENUlaunchDOOM=BACK
if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then MENUlaunchDOOM=" LAUNCH $(head -3 /dev/shm/runcommand.info | tail -1 | sed 's/.*\///')"; fi

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
	1 "><  [dazi-mod-loader]  ><" \
	2 "><  CONFIG [dazi-mod-loader] MENU at [runcommand-onstart]  ><" \
	3 "><  CONFIG [dazi-mod-loader] CLEAN UP at [runcommand-onend]  ><" \
	4 "><  CONFIG [srb2-addons]  ><" \
	5 "><  MANAGE [SymbolicLinks] for [doom.wads]   ><" \
	6 "><  GENERATE [DAZI-Templates.sh] in [../roms/ports]   ><" \
	7 "><  INSTALL [lzdoom-dazi] + [dazi-mod-loader]  ><" \
	8 "><  REMOVE  [lzdoom-dazi] + [dazi-mod-loader]  ><" \
	9 "><  REFERENCES  ><")

if [ "$confCONFIG" == '1' ]; then DMLmainMENU; fi 

# DAZI @runcommand-onstart Settings
if [ "$confCONFIG" == '2' ]; then daziRUNONstartMENU; fi

# DAZI @runcommand-onend Settings
if [ "$confCONFIG" == '3' ]; then daziRUNONendMENU; fi

# SRB2 AddOns
if [ "$confCONFIG" == '4' ]; then srb2ADDONSmenu; fi

# Create SymbolicLinks
if [ "$confCONFIG" == '5' ]; then symLINKSmenu; fi

# Get Templates
if [ "$confCONFIG" == '6' ]; then getDAZIshMENU; fi

# INSTALL [lzdoom-dazi]
if [ "$confCONFIG" == '7' ]; then
	confINSTALLdazi=$(dialog --stdout --no-collapse --title "               INSTALL  [lzdoom-dazi] + [dazi-mod-loader]              " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  INSTALL  [lzdoom-dazi] + [dazi-mod-loader]  ><" \
		2 "><  BACK  ><")
	# Install Confirmed - Otherwise Back to Main Menu
	if [ "$confINSTALLdazi" == '1' ]; then installDAZI; fi
mainMENU
fi

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

# REFERENCES
if [ "$confCONFIG" == '9' ]; then
	dialog --no-collapse --title "[DAZI] for [RetroPie] REFERENCES" --ok-label Back --msgbox "$daziLOGO $zipREFmod $daziHUD $symLINKSref ====================================================================== $daziFILES $zdoomCFGinis $daziHUDsrb2 $srb2FILES $doomWARPdiff $(cat /opt/retropie/configs/ports/doom/emulators.cfg | grep 'default =')"  25 75
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

daziRUNONstartMENU()
{
# 0btain Current Setting
if [ -f /opt/retropie/configs/ports/doom/lzdoom-dazi.flag ]; then
	if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.flag)" == "0" ]; then
		currentFLAGcfg=DISABLED
		currentFLAGhud=$daziHUDoff
	fi
	if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.flag)" == "1" ]; then
		currentFLAGcfg=ENABLED
		currentFLAGhud=$daziHUD
	fi
else
	currentFLAGcfg="???"
	currentFLAGhud=
fi

# Confirm Configurations
RUNONstartCONFIG=$(dialog --stdout --no-collapse --title "   CONFIG  [dazi-mod-loader] MENU at [runcommand-onstart]" \
	--ok-label SELECT --cancel-label "BACK" \
	--menu "$currentFLAGhud \n     SET [dazi-mod-loader] MENU to Load when [doom] P0RT Launches \n     CURRENT SETTING: [$currentFLAGcfg]" 25 75 20 \
	1 ">< ENABLE  [dazi-mod-loader] MENU at [runcommand-onstart] ><" \
	2 ">< DISABLE [dazi-mod-loader] MENU at [runcommand-onstart] ><")

# Turn DAZI @runcommand-onstart ON
if [ "$RUNONstartCONFIG" == '1' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag ON [dazi-mod-loader]
		echo '1' > /opt/retropie/configs/ports/doom/lzdoom-dazi.flag
		dialog --no-collapse --title "ENABLE  [dazi-mod-loader] at [runcommand-onstart]  *COMPLETE!*" --ok-label Back --msgbox "ENABLED... \n$daziHUD"  25 75
	fi
daziRUNONstartMENU
fi
	
# Turn DAZI @runcommand-onstart OFF
if [ "$RUNONstartCONFIG" == '2' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag OFF [dazi-mod-loader]
		echo '0' > /opt/retropie/configs/ports/doom/lzdoom-dazi.flag
		dialog --no-collapse --title "DISABLE  [dazi-mod-loader] at [runcommand-onstart]  *COMPLETE!*" --ok-label Back --msgbox "DISABLED... \n$daziHUDoff"  25 75
	fi
daziRUNONstartMENU
fi

tput reset
mainMENU
}

daziRUNONendMENU()
{
# 0btain Current Setting
if [ -f /opt/retropie/configs/ports/doom/lzdoom-dazi.clean ]; then
	if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == "1" ]; then
		currentCLEANcfg=TMPFS
		currentFLAGhud=$daziHUD
	fi
	if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == "2" ]; then
		currentCLEANcfg=ADDON
		currentFLAGhud=$daziHUD
	fi
	if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == "3" ]; then
		currentCLEANcfg=TMPFS+ADDON
		currentFLAGhud=$daziHUD
	fi
	if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == "0" ]; then
		currentCLEANcfg=DISABLED
		currentFLAGhud=$daziHUDoff
	fi
else
	currentCLEANcfg="???"
	currentFLAGhud=
fi

# Confirm Configurations
RUNONendCONFIG=$(dialog --stdout --no-collapse --title "    CONFIG  [dazi-mod-loader] CLEAN at [runcommand-onend]" \
	--ok-label SELECT --cancel-label "BACK" \
	--menu "$currentFLAGhud \nSET [dazi-mod-loader] to CLEAN Doom [AddOnDIRs] at [runcommand-onend] \n     CURRENT SETTING: [$currentCLEANcfg]" 25 75 20 \
	1 ">< CLEAN UP [TMPFS] at [runcommand-onend] ><" \
	2 ">< CLEAN UP [ADDON] at [runcommand-onend] ><" \
	3 ">< CLEAN UP [TMPFS+ADDON] at [runcommand-onend] ><" \
	4 ">< DISABLE CLEAN [AddOnDIRs] at [runcommand-onend] ><")

# SET  [runcommand-onend] to CLEAN [TMPFS]
if [ "$RUNONendCONFIG" == '1' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag ON [dazi-mod-loader]
		echo '1' > /opt/retropie/configs/ports/doom/lzdoom-dazi.clean
		dialog --no-collapse --title "SET  [runcommand-onend] to CLEAN [TMPFS] *COMPLETE!*" --ok-label Back --msgbox "ENABLED... \n$daziHUD"  25 75
	fi
daziRUNONendMENU
fi
	
# SET  [runcommand-onend] to CLEAN [ADDON]
if [ "$RUNONendCONFIG" == '2' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag OFF [dazi-mod-loader]
		echo '2' > /opt/retropie/configs/ports/doom/lzdoom-dazi.clean
		dialog --no-collapse --title "SET  [runcommand-onend] to CLEAN [ADDON] *COMPLETE!*" --ok-label Back --msgbox "ENABLED... \n$daziHUD"  25 75
	fi
daziRUNONendMENU
fi

# SET  [runcommand-onend] to CLEAN [BOTH] TMPFS+ADDON
if [ "$RUNONendCONFIG" == '3' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag OFF [dazi-mod-loader]
		echo '3' > /opt/retropie/configs/ports/doom/lzdoom-dazi.clean
		dialog --no-collapse --title "SET  [runcommand-onend] to CLEAN [TMPFS+ADDON] *COMPLETE!*" --ok-label Back --msgbox "ENABLED... \n$daziHUD"  25 75
	fi
daziRUNONendMENU
fi

# DISABLE CLEAN [AddOnDIRs] at [runcommand-onend]
if [ "$RUNONendCONFIG" == '4' ]; then 
	if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
		dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	else
		# Toggle [runcommand] Flag OFF [dazi-mod-loader]
		echo '0' > /opt/retropie/configs/ports/doom/lzdoom-dazi.clean
		dialog --no-collapse --title "DISABLE CLEAN [AddOnDIRs] at [runcommand-onend] *COMPLETE!*" --ok-label Back --msgbox "DISABLED... \n$daziHUDoff"  25 75
	fi
daziRUNONendMENU
fi

tput reset
mainMENU
}

symLINKSmenu()
{

# Create SymbolicLinks
confLINKSdazi=$(dialog --stdout --no-collapse --title " MANAGE [SymbolicLinks] for [doom.wads]: {ln -s doom.wad doom-symlink.wad}" \
	--ok-label OK --cancel-label BACK \
	--menu "$symLINKSref" 25 75 20 \
	1 "><  AUTO-CREATE  [SymbolicLinks] for [doom.wads]  ><" \
	2 "><  AUTO-REMOVE  [SymbolicLinks] for [doom.wads]  ><" \
	3 "><  USER CREATE  [SymbolicLinks] for [doom.wads]  ><" \
	4 "><  USER REMOVE  [SymbolicLinks] for [doom.wads]  ><" \
	5 "><  VIEW CURRENT [SymbolicLinks]  ><")
# Confirmed - Otherwise Back to Main Menu
if [ "$confLINKSdazi" == '1' ]; then autoCREATElinks; fi
if [ "$confLINKSdazi" == '2' ]; then autoREMOVElinks; fi
if [ "$confLINKSdazi" == '3' ]; then userCREATElinks; fi
if [ "$confLINKSdazi" == '4' ]; then userREMOVElinks; fi

# REFERENCES for SymbolicLinks
if [ "$confLINKSdazi" == '5' ]; then
	# Update [symLINKSwads] when entering menu
	symLINKSwads=$(
	echo ""
	echo '===========[WADFile]=========================={SymbolicLink}=========='
	echo "         chex.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/chex.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep chex-warp.wad )"
	echo "         chex2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/chex2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep chex2-warp.wad )"
	echo "         chex3.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/chex3.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep chex3-warp.wad )"
	echo "         doom.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom-warp.wad )"
	echo "         doom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom2-warp.wad | grep -v freedoom2 )"
	echo "         doomu.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doomu-warp.wad )"
	echo "         freedoom1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom1-warp.wad )"
	echo "         freedoom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom2-warp.wad )"
	echo "         hacx.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hacx.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hacx-warp.wad )"
	echo "         heretic.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep heretic-warp.wad )"
	echo "         hexen.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hexen-warp.wad )"
	echo "         plutonia.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then echo "???"; fi)                       $(ls -1 ~/RetroPie/roms/ports/doom/ | grep plutonia-warp.wad )"
	echo "         strife1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep strife1-warp.wad )"
	echo "         sve.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/sve.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep sve-warp.wad )"
	echo "         tnt.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep tnt-warp.wad )"
	echo "======================================================================"
	#echo ""
	echo "                    ~/RetroPie/roms/ports/doom/                       "
	)
	dialog --no-collapse --title "VIEW Current [SymbolicLinks] for [doom.wads]:" --ok-label Back --msgbox " $symLINKSwads $(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | grep -v chex-warp.wad | grep -v chex2-warp.wad | grep -v chex3-warp.wad | grep -v doom-warp.wad | grep -v doom2-warp.wad | grep -v doomu-warp.wad | grep -v freedoom1-warp.wad | grep -v freedoom2-warp.wad | grep -v hacx-warp.wad | grep -v heretic-warp.wad | grep -v hexen-warp.wad | grep -v plutonia-warp.wad | grep -v strife1-warp.wad | grep -v sve-warp.wad | grep -v tnt-warp.wad | sort -n ) ====================================================================== CURRENT EMULATOR SETTINGS: [/opt/retropie/configs/all/emulators.cfg]                      $(cat /opt/retropie/configs/all/emulators.cfg | grep 'lzdoom-dazi+warp')"  25 75
	symLINKSmenu
fi
mainMENU
}

autoCREATElinks()
{
tput reset

if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
	dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	symLINKSmenu
fi

# Backup emulators.cfg if not exist already
if [ ! -f /opt/retropie/configs/all/emulators.cfg ]; then touch /opt/retropie/configs/all/emulators.cfg 2>/dev/null; fi
if [ ! -f /opt/retropie/configs/all/emulators.cfg.b4dazi ]; then cp /opt/retropie/configs/all/emulators.cfg /opt/retropie/configs/all/emulators.cfg.b4dazi 2>/dev/null; fi

# Check for Main [doom.wad] Files - Create Symbolic Links If Found - Set [lzdoom-addon] for all FOUND LINKS in [emulators.cfg]
if [ -f ~/RetroPie/roms/ports/doom/chex.wad ]; then
	rm ~/RetroPie/roms/ports/doom/chex-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/chex.wad ~/RetroPie/roms/ports/doom/chex-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_chex-warp =' ; echo $?) == '0' ]; then
		echo 'doom_chex-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_chex-warp\ =.*/doom\_chex-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/chex2.wad ]; then
	rm ~/RetroPie/roms/ports/doom/chex2-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/chex2.wad ~/RetroPie/roms/ports/doom/chex2-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_chex2-warp =' ; echo $?) == '0' ]; then
		echo 'doom_chex2-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_chex2-warp\ =.*/doom\_chex2-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/chex3.wad ]; then
	rm ~/RetroPie/roms/ports/doom/chex3-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/chex3.wad ~/RetroPie/roms/ports/doom/chex3-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_chex3-warp =' ; echo $?) == '0' ]; then
		echo 'doom_chex3-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_chex3-warp\ =.*/doom\_chex3-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/doom.wad ]; then
	rm ~/RetroPie/roms/ports/doom/doom-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doom.wad ~/RetroPie/roms/ports/doom/doom-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_doom-warp =' ; echo $?) == '0' ]; then
		echo 'doom_doom-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_doom-warp\ =.*/doom\_doom-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then
	rm ~/RetroPie/roms/ports/doom/doom2-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doom2.wad ~/RetroPie/roms/ports/doom/doom2-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_doom2-warp =' ; echo $?) == '0' ]; then
		echo 'doom_doom2-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_doom2-warp\ =.*/doom\_doom2-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then
	rm ~/RetroPie/roms/ports/doom/doomu-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doomu.wad ~/RetroPie/roms/ports/doom/doomu-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_doomu-warp =' ; echo $?) == '0' ]; then
		echo 'doom_doomu-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_doomu-warp\ =.*/doom\_doomu-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then
	rm ~/RetroPie/roms/ports/doom/freedoom1-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom1.wad ~/RetroPie/roms/ports/doom/freedoom1-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_freedoom1-warp =' ; echo $?) == '0' ]; then
		echo 'doom_freedoom1-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_freedoom1-warp\ =.*/doom\_freedoom1-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then
	rm ~/RetroPie/roms/ports/doom/freedoom2-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom2.wad ~/RetroPie/roms/ports/doom/freedoom2-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_freedoom2-warp =' ; echo $?) == '0' ]; then
		echo 'doom_freedoom2-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_freedoom2-warp\ =.*/doom\_freedoom2-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/hacx.wad ]; then
	rm ~/RetroPie/roms/ports/doom/hacx-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/hacx.wad ~/RetroPie/roms/ports/doom/hacx-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_hacx-warp =' ; echo $?) == '0' ]; then
		echo 'doom_hacx-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_hacx-warp\ =.*/doom\_hacx-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then
	rm ~/RetroPie/roms/ports/doom/heretic-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/heretic.wad ~/RetroPie/roms/ports/doom/heretic-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_heretic-warp =' ; echo $?) == '0' ]; then
		echo 'doom_heretic-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_heretic-warp\ =.*/doom\_heretic-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then
	rm ~/RetroPie/roms/ports/doom/hexen-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/hexen.wad ~/RetroPie/roms/ports/doom/hexen-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_hexen-warp =' ; echo $?) == '0' ]; then
		echo 'doom_hexen-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_hexen-warp\ =.*/doom\_hexen-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then
	rm ~/RetroPie/roms/ports/doom/plutonia-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/plutonia.wad ~/RetroPie/roms/ports/doom/plutonia-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_plutonia-warp =' ; echo $?) == '0' ]; then
		echo 'doom_plutonia-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_plutonia-warp\ =.*/doom\_plutonia-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then
	rm ~/RetroPie/roms/ports/doom/strife1-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/strife1.wad ~/RetroPie/roms/ports/doom/strife1-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_strife1-warp =' ; echo $?) == '0' ]; then
		echo 'doom_strife1-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_strife1-warp\ =.*/doom\_strife1-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/sve.wad ]; then
	rm ~/RetroPie/roms/ports/doom/sve-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/sve.wad ~/RetroPie/roms/ports/doom/sve-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_sve-warp =' ; echo $?) == '0' ]; then
		echo 'doom_sve-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_sve-warp\ =.*/doom\_sve-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then
	rm ~/RetroPie/roms/ports/doom/tnt-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/tnt.wad ~/RetroPie/roms/ports/doom/tnt-warp.wad 2>/dev/null
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_tnt-warp =' ; echo $?) == '0' ]; then
		echo 'doom_tnt-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_tnt-warp\ =.*/doom\_tnt-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

# FINISHED
dialog --no-collapse --title "CREATE [SymbolicLinks] for STANDARD [doom.wads] *COMPLETE!* " --ok-label Back --msgbox "Current [SymbolicLinks] for [doom.wads] in [../roms/ports/doom/*]:      $(ls ~/RetroPie/roms/ports/doom/ | grep warp.wad | sort -n) ====================================================================== CURRENT EMULATOR SETTINGS: [/opt/retropie/configs/all/emulators.cfg]                      $(cat /opt/retropie/configs/all/emulators.cfg | grep 'lzdoom-dazi+warp')"  25 75

symLINKSmenu
}

autoREMOVElinks()
{
tput reset

# REMOVE Symbolic Links
rm ~/RetroPie/roms/ports/doom/chex-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/chex2-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/chex3-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doom-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doom2-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doomu-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/freedoom1-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/freedoom2-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/hacx-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/heretic-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/hexen-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/plutonia-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/strife1-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/sve-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/tnt-warp.wad 2>/dev/null

# REMOVE Symbolic Links Emulators Entries for [lzdoom-dazi+warp]
sed -i "/chex-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/chex2-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/chex3-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/doom-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/doom2-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/doomu-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/freedoom1-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/freedoom2-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/hacx-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/heretic-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/hexen-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/plutonia-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/strife1-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/sve-warp/d" /opt/retropie/configs/all/emulators.cfg
sed -i "/tnt-warp/d" /opt/retropie/configs/all/emulators.cfg

if [ ! -f /opt/retropie/configs/all/emulators.cfg.b4dazi ]; then cp /opt/retropie/configs/all/emulators.cfg /opt/retropie/configs/all/emulators.cfg.b4dazi 2>/dev/null; fi
#cat /opt/retropie/configs/all/emulators.cfg | grep -v 'lzdoom-dazi+warp' > /dev/shm/emulators.cfg
#mv /dev/shm/emulators.cfg /opt/retropie/configs/all/emulators.cfg

# FINISHED
dialog --no-collapse --title "REMOVE [SymbolicLinks]  for STANDARD [doom.wads] *COMPLETE!* " --ok-label Back --msgbox "Current [SymbolicLinks] for [doom.wads] in [../roms/ports/doom/*]:      $(ls ~/RetroPie/roms/ports/doom/ | grep warp.wad | sort -n) ====================================================================== CURRENT EMULATOR SETTINGS: [/opt/retropie/configs/all/emulators.cfg]                      $(cat /opt/retropie/configs/all/emulators.cfg | grep 'lzdoom-dazi+warp')"  25 75

symLINKSmenu
}

userCREATElinks()
{
tput reset

if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
	dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	symLINKSmenu
fi

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
FILE=$(dialog --title "Select WAD from $doomDIRwads" --ok-label SELECT --cancel-label BACK --menu "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] \n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $doomDIRwads -maxdepth 1 -type f | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	if [[ "$selectFILE" == *".wad" ]] || [[ "$selectFILE" == *".WAD" ]]; then
		userWADlink="$(echo $selectFILE | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' )-warp.wad"
		selectFILEemu="$(echo $selectFILE | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' )-warp"
		rm "$doomDIRwads/$userWADlink" 2>/dev/null
		ln -s "$doomDIRwads/$selectFILE" "$doomDIRwads/$userWADlink"
		# Add [to emulators.cfg]
		if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q "doom_$selectFILEemu =" ; echo $?) == '0' ]; then
			echo "doom_$selectFILEemu = \"lzdoom-dazi+warp\"" >> /opt/retropie/configs/all/emulators.cfg
		else
			sed -i "s/doom\_$selectFILEemu\ =.*/doom\_$selectFILEemu\ =\ \"lzdoom-dazi+warp\"/g" /opt/retropie/configs/all/emulators.cfg
		fi
	else
		dialog --no-collapse --title "  NOT A WAD FILE: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] [SymbolicLinks]:\n \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
		userCREATElinks
	fi
	dialog --no-collapse --title "  SYMBOLIC LINK to WAD Added: [$selectFILE] <-> [$userWADlink]  " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] [SymbolicLinks]:\n  \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
	userCREATElinks
fi

symLINKSmenu
}

userREMOVElinks()
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
FILE=$(dialog --title "Remove WAD from $doomDIRwads" --ok-label SELECT --cancel-label BACK --menu "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] \n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n | sed -n "`echo "$FILE p" | sed 's/ //'`")
	selectFILEemu="$(echo $selectFILE | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' | perl -ple 'chop' )"
	if [[ "$selectFILE" == *".wad" ]] || [[ "$selectFILE" == *".WAD" ]]; then
		rm "$doomDIRwads/$selectFILE" 2>/dev/null
		sed -i "/$selectFILEemu/d" /opt/retropie/configs/all/emulators.cfg
		dialog --no-collapse --title "  SYMBOLIC LINK REMOVED: [$selectFILE] " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] [SymbolicLinks]:\n  \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n )\n"  25 75
		userREMOVElinks
	else
		dialog --no-collapse --title "  NOT A WAD FILE: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$doomDIRwads] FreeSpace: [$(df -h $doomDIRwads |awk '{print $4}' | grep -v Avail )] [SymbolicLinks]:\n \n$(find $doomDIRwads -maxdepth 1 -type l | sed 's|.*/||' | sort -n ) [SymbolicLinks]\n"  25 75
		userREMOVElinks
	fi
fi

symLINKSmenu
}

removeDAZI()
{
tput reset

# Backup emulators.cfg if not exist already
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi ]; then cp /opt/retropie/configs/ports/doom/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg.bakdazi 2>/dev/null; fi

cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -v 'lzdoom-dazi-' | grep -v 'lzdoom-dazi =' | grep -v 'default =' | grep -v 'lzdoom-dazi+' > /dev/shm/emulators.cfg
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

# Remove [lzdoom-dazi] from  [runcommand-onend.sh]
if [ -f /opt/retropie/configs/all/runcommand-onend.sh ]; then
	# Backup [runcommand-onend.sh] not exist already
	if [ ! -f /opt/retropie/configs/all/runcommand-onend.sh.bakdazi ]; then cp /opt/retropie/configs/all/runcommand-onend.sh /opt/retropie/configs/all/runcommand-onend.sh.bakdazi 2>/dev/null; fi	
	
	# Rebuild [runcommand-onend.sh] without [lzdoom-dazi]
	cat /opt/retropie/configs/all/runcommand-onend.sh | grep -v 'lzdoom-dazi' > /dev/shm/runcommand-onend.sh
	mv /dev/shm/runcommand-onend.sh /opt/retropie/configs/all/runcommand-onend.sh
fi

# Remove [lzdoom-dazi.sh]
rm /opt/retropie/configs/ports/doom/lzdoom-dazi.sh 2>/dev/null
rm /opt/retropie/configs/ports/doom/lzdoom-dazi.flag 2>/dev/null
rm /opt/retropie/configs/ports/doom/lzdoom-dazi.clean 2>/dev/null

# REMOVE Symbolic Links
rm ~/RetroPie/roms/ports/doom/chex-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/chex2-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/chex3-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doom-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doom2-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/doomu-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/freedoom1-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/freedoom2-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/hacx-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/heretic-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/hexen-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/plutonia-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/strife1-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/sve-warp.wad 2>/dev/null
rm ~/RetroPie/roms/ports/doom/tnt-warp.wad 2>/dev/null

# REMOVE Symbolic Links Emulators Entries for [lzdoom-dazi+warp]
if [ ! -f /opt/retropie/configs/all/emulators.cfg.b4dazi ]; then cp /opt/retropie/configs/all/emulators.cfg /opt/retropie/configs/all/emulators.cfg.b4dazi 2>/dev/null; fi
cat /opt/retropie/configs/all/emulators.cfg | grep -v 'lzdoom-dazi+warp' > /dev/shm/emulators.cfg
mv /dev/shm/emulators.cfg /opt/retropie/configs/all/emulators.cfg

# REMOVE DAZI Templates
rm ~/RetroPie/roms/ports/'0ne Humanity (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 2 (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 2 (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 3 (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 3 (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom I (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom II (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom II (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom I (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom SIGIL (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom Ultimate (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom Ultimate (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase I (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase II (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase II (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase I (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'HacX (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'HacX (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Heretic (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Heretic (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Hexen (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Hexen (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Plutonia (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Plutonia (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife Veteren Edition (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife Veteren Edition (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'TNT (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'TNT (WARP).sh' 2>/dev/null

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
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -v 'lzdoom-dazi-' | grep -v 'lzdoom-dazi =' | grep -v 'lzdoom-dazi+' > /dev/shm/emulators.cfg
cat /opt/retropie/configs/ports/doom/emulators.cfg | grep 'lzdoom-addon' > /dev/shm/emulators.dazi
if [ "$(cat /dev/shm/emulators.dazi | grep -q 'lzdoom-addon =' ; echo $?)" == '1' ]; then
	echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 -config /home/$USER/RetroPie/roms/ports/doom/lzdoom.ini +vid_renderer 0 +'snd_mididevice -2' -file /home/$USER/RetroPie/roms/ports/doom/addon/*\"" > /dev/shm/emulators.dazi
	echo "lzdoom-addon = \"DOOMWADDIR=/home/$USER/RetroPie/roms/ports/doom /opt/retropie/ports/lzdoom/lzdoom -iwad %ROM% +fullscreen 1 -config /home/$USER/RetroPie/roms/ports/doom/lzdoom.ini +vid_renderer 0 +'snd_mididevice -2' -file /home/$USER/RetroPie/roms/ports/doom/addon/*\"" >> /dev/shm/emulators.cfg
fi

# Create [dazi+warp] entry based on current [lzdoom-addon] entry in [emulators.cfg]
cat /dev/shm/emulators.dazi | grep 'lzdoom-addon =' > /dev/shm/emulators.dazipluswarp
sed -i 's/lzdoom-addon/lzdoom-dazi+warp/g' /dev/shm/emulators.dazipluswarp
sed -i "s+-file\ .*+-file\ \/dev\/shm\/addon/\*\ -file\ \/home\/$USER\/RetroPie\/roms\/ports\/doom\/addon/\*\ -warp\ 1\ 1\ -skill\ 3\"+g" /dev/shm/emulators.dazipluswarp

# Create [dazi+] entry based on current [lzdoom-addon] entry in [emulators.cfg]
cat /dev/shm/emulators.dazi | grep 'lzdoom-addon =' > /dev/shm/emulators.daziplus
sed -i 's/lzdoom-addon/lzdoom-dazi+/g' /dev/shm/emulators.daziplus
sed -i "s+-file\ .*+-file\ \/dev\/shm\/addon/\*\ -file\ \/home\/$USER\/RetroPie\/roms\/ports\/doom\/addon/\*\"+g" /dev/shm/emulators.daziplus

# Create [dazi] entry based on current [lzdoom-addon] entry in [emulators.cfg]
sed -i 's/lzdoom-addon/lzdoom-dazi/g' /dev/shm/emulators.dazi
sed -i 's/~\/RetroPie\/roms\/ports\/doom\/addon\//\/dev\/shm\/addon\//g' /dev/shm/emulators.dazi
sed -i "s/\/home\/$USER\/RetroPie\/roms\/ports\/doom\/addon\//\/dev\/shm\/addon\//g" /dev/shm/emulators.dazi

# Add the [dazi] and dazi+] entries
cat /dev/shm/emulators.dazi >> /dev/shm/emulators.cfg
cat /dev/shm/emulators.daziplus >> /dev/shm/emulators.cfg
cat /dev/shm/emulators.dazipluswarp >> /dev/shm/emulators.cfg

# Configure [dazi] as DEFAULT in [emulators.cfg]
if [ "$(cat /opt/retropie/configs/ports/doom/emulators.cfg | grep -q 'default =' ; echo $?)" == '1' ]; then echo 'default = "lzdoom"' >> /dev/shm/emulators.cfg; fi
sed -i 's/default\ =.*/default\ =\ \"lzdoom-dazi+\"/g' /dev/shm/emulators.cfg

# Replace [emulators.cfg]
mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/doom/emulators.cfg 2>/dev/null

# Cleanup
rm /dev/shm/emulators.cfg 2>/dev/null
rm /dev/shm/emulators.dazi 2>/dev/null
rm /dev/shm/emulators.daziplus 2>/dev/null
rm /dev/shm/emulators.dazipluswarp 2>/dev/null

# Update [runcommand-onstart.sh] to BLANK the [runcommand.log] 0NLY IF [lzdoom-dazi] is Called
# Ensures the PRE-LOAD D00M-M0Ds Using [EXIT WITHOUT LAUNCHING] Feature remains Functional
if [ ! -f /opt/retropie/configs/all/runcommand-onstart.sh ]; then touch /opt/retropie/configs/all/runcommand-onstart.sh; fi

# Backup [runcommand-onstart.sh] not exist already
if [ ! -f /opt/retropie/configs/all/runcommand-onstart.sh.bakdazi ]; then cp /opt/retropie/configs/all/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh.bakdazi 2>/dev/null; fi

# Rebuild [runcommand-onstart.sh] with [lzdoom-dazi]
if [ "$(cat /opt/retropie/configs/all/runcommand-onstart.sh | tail -n 1 | grep -q "lzdoom-dazi" ; echo $?)" == '1' ]; then
	# Needs to be the LAST Line in [runcommand-onstart.sh] to Properly BLANK the [runcommand.log]
	cat /opt/retropie/configs/all/runcommand-onstart.sh | grep -v 'lzdoom-dazi' > /dev/shm/runcommand-onstart.sh
	echo "if [[ \"\$1\" == \"doom\" ]] && [[ \"\$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.flag)\" == '1' ]]; then cat /dev/null > /dev/shm/runcommand.log && sudo /home/$USER/RetroPie-Setup/retropie_packages.sh retropiemenu launch \"/opt/retropie/configs/ports/doom/lzdoom-dazi.sh\" </dev/tty > /dev/tty; fi #For Use With [lzdoom-dazi] #Line Should be LAST" >> /dev/shm/runcommand-onstart.sh
	mv /dev/shm/runcommand-onstart.sh /opt/retropie/configs/all/runcommand-onstart.sh
fi

# Update [runcommand-onend.sh] to Clean up the AddOn DIRs
if [ ! -f /opt/retropie/configs/all/runcommand-onend.sh ]; then touch /opt/retropie/configs/all/runcommand-onend.sh; fi

# Backup [runcommand-onend.sh] not exist already
if [ ! -f /opt/retropie/configs/all/runcommand-onend.sh.bakdazi ]; then cp /opt/retropie/configs/all/runcommand-onend.sh /opt/retropie/configs/all/runcommand-onend.sh.bakdazi 2>/dev/null; fi

# Rebuild [runcommand-onend.sh] with [lzdoom-dazi]
if [ "$(cat /opt/retropie/configs/all/runcommand-onend.sh | tail -n 1 | grep -q "lzdoom-dazi" ; echo $?)" == '1' ]; then
	# Should be the LAST Line in [runcommand-onend.sh]
	cat /opt/retropie/configs/all/runcommand-onend.sh | grep -v 'lzdoom-dazi' > /dev/shm/runcommand-onend.sh
	echo 'if [ "$(head -1 /dev/shm/runcommand.info)" == "doom" ]; then bash /opt/retropie/configs/ports/doom/lzdoom-dazi.sh clean; fi & #For Use With [lzdoom-dazi] #Line can be LAST'  >> /dev/shm/runcommand-onend.sh
	mv /dev/shm/runcommand-onend.sh /opt/retropie/configs/all/runcommand-onend.sh
fi

# Add Settings File [lzdoom-dazi.clean] for the Clean up of AddOn DIRs
if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.clean ]; then echo '1' > /opt/retropie/configs/ports/doom/lzdoom-dazi.clean; fi

# This script will behave differently depending on the location - copy itself to install location
cp "$0" /dev/shm/lzdoom-dazi.sh
mv /dev/shm/lzdoom-dazi.sh /opt/retropie/configs/ports/doom/lzdoom-dazi.sh
sudo chmod 755 /opt/retropie/configs/ports/doom/lzdoom-dazi.sh

# Toggle [runcommand] Flag ON [dazi-mod-loader]
echo '1' > /opt/retropie/configs/ports/doom/lzdoom-dazi.flag

# FINISHED
dialog --no-collapse --title "INSTALL [DAZI] for [RetroPie]  *COMPLETE!* " --ok-label Back --msgbox "$daziLOGO $zipREFmod $daziHUD $symLINKSref ====================================================================== $daziFILES $doomWARPdiff $(cat /opt/retropie/configs/ports/doom/emulators.cfg | grep 'default =')"  25 75

mainMENU
}

getDAZIshMENU()
{
# Update when entering menu
symLINKSwads=$(
	#echo ""
	echo '===========[WADFile]=========================={SymbolicLink}=========='
	echo "         chex.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/chex.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep chex-warp.wad )"
	echo "         chex2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/chex2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep chex2-warp.wad )"
	echo "         chex3.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/chex3.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep chex3-warp.wad )"
	echo "         doom.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom-warp.wad )"
	echo "         doom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doom2-warp.wad | grep -v freedoom2 )"
	echo "         doomu.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep doomu-warp.wad )"
	echo "         freedoom1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom1-warp.wad )"
	echo "         freedoom2.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then echo "???"; fi)                      $(ls -1 ~/RetroPie/roms/ports/doom/ | grep freedoom2-warp.wad )"
	echo "         hacx.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hacx.wad ]; then echo "???"; fi)                           $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hacx-warp.wad )"
	echo "         heretic.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep heretic-warp.wad )"
	echo "         hexen.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then echo "???"; fi)                          $(ls -1 ~/RetroPie/roms/ports/doom/ | grep hexen-warp.wad )"
	echo "         plutonia.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then echo "???"; fi)                       $(ls -1 ~/RetroPie/roms/ports/doom/ | grep plutonia-warp.wad )"
	echo "         strife1.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then echo "???"; fi)                        $(ls -1 ~/RetroPie/roms/ports/doom/ | grep strife1-warp.wad )"
	echo "         sve.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/sve.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep sve-warp.wad )"
	echo "         tnt.wad $(if [ ! -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then echo "???"; fi)                            $(ls -1 ~/RetroPie/roms/ports/doom/ | grep tnt-warp.wad )"
	#echo "======================================================================"
	#echo ""
	#echo "                    ~/RetroPie/roms/ports/doom/                       "
	)

confGETdazi=$(dialog --stdout --no-collapse --title "             GENERATE [DAZI-Templates.sh] in [../roms/ports]              " \
	--ok-label OK --cancel-label BACK \
	--menu "$symLINKSwads" 25 75 20 \
	1 "><  GENERATE [DAZI-Templates.sh] in [../roms/ports]  ><" \
	2 "><  REMOVE ALL [DAZI-Templates.sh] in [../roms/ports]  ><" \
	3 "><  VIEW Current [DAZI-Templates.sh] in [../roms/ports]  ><")
# Confirmed - Otherwise Back to Main Menu
if [ "$confGETdazi" == '1' ]; then getDAZIsh; fi
if [ "$confGETdazi" == '2' ]; then removeDAZIsh; fi
if [ "$confGETdazi" == '3' ]; then
	dialog --no-collapse --title "VIEW Current [DAZI-Templates.sh] and [WARP-Templates.sh] in [../roms/ports]:" --ok-label Back --msgbox "$(find ~/RetroPie/roms/ports/ -maxdepth 1 -type f | grep '(DAZI).sh' | sed 's|.*/||' | sort -n ) $(find ~/RetroPie/roms/ports/ -maxdepth 1 -type f | grep '(WARP).sh' | sed 's|.*/||' | sort -n )"  25 75
	getDAZIshMENU
fi
mainMENU
}	

getDAZIsh()
{
tput reset

if [ ! -f /opt/retropie/configs/ports/doom/lzdoom-dazi.sh ]; then
	dialog --no-collapse --title " [/opt/retropie/configs/ports/doom/lzdoom-dazi.sh] NOT FOUND!  " --ok-label CONTINUE --msgbox "\n INSTALL [DAZI] FIRST...\n"  25 75
	getDAZIshMENU
fi

# =====================================
# DAZI Templates
if [ -f ~/RetroPie/roms/ports/doom/chex.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Chex\ Quest\ \(DAZI\).sh
	sed -i 's/doom1.wad/chex.wad/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Chex\ Quest\ \(DAZI\).sh ~/RetroPie/roms/ports/Chex\ Quest\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/chex-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/chex.wad ~/RetroPie/roms/ports/doom/chex-warp.wad 2>/dev/null
	sed -i 's/chex.wad/chex-warp.wad/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=4/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=9/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Chex\ Quest\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_chex-warp =' ; echo $?) == '0' ]; then
		echo 'doom_chex-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_chex-warp\ =.*/doom\_chex-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/chex2.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(DAZI\).sh
	sed -i 's/doom1.wad/chex2.wad/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(DAZI\).sh ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/chex2-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/chex2.wad ~/RetroPie/roms/ports/doom/chex2-warp.wad 2>/dev/null
	sed -i 's/chex2.wad/chex2-warp.wad/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=1/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=3/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Chex\ Quest\ 2\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_chex2-warp =' ; echo $?) == '0' ]; then
		echo 'doom_chex2-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_chex2-warp\ =.*/doom\_chex2-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/chex3.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(DAZI\).sh
	sed -i 's/doom1.wad/chex3.wad/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(DAZI\).sh ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/chex3-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/chex3.wad ~/RetroPie/roms/ports/doom/chex3-warp.wad 2>/dev/null
	sed -i 's/chex3.wad/chex3-warp.wad/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=3/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=5/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Chex\ Quest\ 3\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_chex3-warp =' ; echo $?) == '0' ]; then
		echo 'doom_chex3-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_chex3-warp\ =.*/doom\_chex3-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/doom.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Doom\ I\ \(DAZI\).sh
	sed -i 's/doom1.wad/doom.wad/g' ~/RetroPie/roms/ports/Doom\ I\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Doom\ I\ \(DAZI\).sh ~/RetroPie/roms/ports/Doom\ I\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Doom\ I\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Doom\ I\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Doom\ I\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/doom-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doom.wad ~/RetroPie/roms/ports/doom/doom-warp.wad 2>/dev/null
	sed -i 's/doom.wad/doom-warp.wad/g' ~/RetroPie/roms/ports/Doom\ I\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=1/g' ~/RetroPie/roms/ports/Doom\ I\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=9/g' ~/RetroPie/roms/ports/Doom\ I\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Doom\ I\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_doom-warp =' ; echo $?) == '0' ]; then
		echo 'doom_doom-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_doom-warp\ =.*/doom\_doom-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/doom2.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Doom\ II\ \(DAZI\).sh
	sed -i 's/doom1.wad/doom2.wad/g' ~/RetroPie/roms/ports/Doom\ II\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Doom\ II\ \(DAZI\).sh ~/RetroPie/roms/ports/Doom\ II\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Doom\ II\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Doom\ II\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Doom\ II\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/doom2-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doom2.wad ~/RetroPie/roms/ports/doom/doom2-warp.wad 2>/dev/null
	sed -i 's/doom2.wad/doom2-warp.wad/g' ~/RetroPie/roms/ports/Doom\ II\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Doom\ II\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=31/g' ~/RetroPie/roms/ports/Doom\ II\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Doom\ II\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_doom2-warp =' ; echo $?) == '0' ]; then
		echo 'doom_doom2-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_doom2-warp\ =.*/doom\_doom2-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/doomu.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Doom\ Ultimate\ \(DAZI\).sh
	sed -i 's/doom1.wad/doomu.wad/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Doom\ Ultimate\ \(DAZI\).sh ~/RetroPie/roms/ports/Doom\ Ultimate\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/doomu-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/doomu.wad ~/RetroPie/roms/ports/doom/doomu-warp.wad 2>/dev/null
	sed -i 's/doomu.wad/doomu-warp.wad/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=4/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=1/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Doom\ Ultimate\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_doomu-warp =' ; echo $?) == '0' ]; then
		echo 'doom_doomu-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_doomu-warp\ =.*/doom\_doomu-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/freedoom1.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh
	sed -i 's/doom1.wad/freedoom1.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/freedoom1-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom1.wad ~/RetroPie/roms/ports/doom/freedoom1-warp.wad 2>/dev/null
	sed -i 's/freedoom1.wad/freedoom1-warp.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=1/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=9/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ I\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_freedoom1-warp =' ; echo $?) == '0' ]; then
		echo 'doom_freedoom1-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_freedoom1-warp\ =.*/doom\_freedoom1-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/freedoom2.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh
	sed -i 's/doom1.wad/freedoom2.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/freedoom2-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/freedoom2.wad ~/RetroPie/roms/ports/doom/freedoom2-warp.wad 2>/dev/null
	sed -i 's/freedoom2.wad/freedoom2-warp.wad/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=32/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Freedoom\ Phase\ II\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_freedoom2-warp =' ; echo $?) == '0' ]; then
		echo 'doom_freedoom2-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_freedoom2-warp\ =.*/doom\_freedoom2-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/hacx.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/HacX\ \(DAZI\).sh
	sed -i 's/doom1.wad/hacx.wad/g' ~/RetroPie/roms/ports/HacX\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/HacX\ \(DAZI\).sh ~/RetroPie/roms/ports/HacX\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/HacX\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/HacX\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/HacX\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/hacx-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/hacx.wad ~/RetroPie/roms/ports/doom/hacx-warp.wad 2>/dev/null
	sed -i 's/hacx.wad/hacx-warp.wad/g' ~/RetroPie/roms/ports/HacX\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/HacX\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=35/g' ~/RetroPie/roms/ports/HacX\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/HacX\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_hacx-warp =' ; echo $?) == '0' ]; then
		echo 'doom_hacx-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_hacx-warp\ =.*/doom\_hacx-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/heretic.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Heretic\ \(DAZI\).sh
	sed -i 's/doom1.wad/heretic.wad/g' ~/RetroPie/roms/ports/Heretic\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Heretic\ \(DAZI\).sh ~/RetroPie/roms/ports/Heretic\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Heretic\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Heretic\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Heretic\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/heretic-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/heretic.wad ~/RetroPie/roms/ports/doom/heretic-warp.wad 2>/dev/null
	sed -i 's/heretic.wad/heretic-warp.wad/g' ~/RetroPie/roms/ports/Heretic\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=6/g' ~/RetroPie/roms/ports/Heretic\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=1/g' ~/RetroPie/roms/ports/Heretic\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Heretic\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_heretic-warp =' ; echo $?) == '0' ]; then
		echo 'doom_heretic-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_heretic-warp\ =.*/doom\_heretic-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/hexen.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Hexen\ \(DAZI\).sh
	sed -i 's/doom1.wad/hexen.wad/g' ~/RetroPie/roms/ports/Hexen\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Hexen\ \(DAZI\).sh ~/RetroPie/roms/ports/Hexen\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Hexen\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Hexen\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Hexen\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/hexen-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/hexen.wad ~/RetroPie/roms/ports/doom/hexen-warp.wad 2>/dev/null
	sed -i 's/hexen.wad/hexen-warp.wad/g' ~/RetroPie/roms/ports/Hexen\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Hexen\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=40/g' ~/RetroPie/roms/ports/Hexen\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Hexen\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_hexen-warp =' ; echo $?) == '0' ]; then
		echo 'doom_hexen-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_hexen-warp\ =.*/doom\_hexen-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/plutonia.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Plutonia\ \(DAZI\).sh
	sed -i 's/doom1.wad/plutonia.wad/g' ~/RetroPie/roms/ports/Plutonia\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Plutonia\ \(DAZI\).sh ~/RetroPie/roms/ports/Plutonia\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Plutonia\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Plutonia\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Plutonia\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/plutonia-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/plutonia.wad ~/RetroPie/roms/ports/doom/plutonia-warp.wad 2>/dev/null
	sed -i 's/plutonia.wad/plutonia-warp.wad/g' ~/RetroPie/roms/ports/Plutonia\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Plutonia\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=32/g' ~/RetroPie/roms/ports/Plutonia\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Plutonia\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_plutonia-warp =' ; echo $?) == '0' ]; then
		echo 'doom_plutonia-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_plutonia-warp\ =.*/doom\_plutonia-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/strife1.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Strife\ \(DAZI\).sh
	sed -i 's/doom1.wad/strife1.wad/g' ~/RetroPie/roms/ports/Strife\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Strife\ \(DAZI\).sh ~/RetroPie/roms/ports/Strife\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Strife\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Strife\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Strife\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/strife1-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/strife1.wad ~/RetroPie/roms/ports/doom/strife1-warp.wad 2>/dev/null
	sed -i 's/strife1.wad/strife1-warp.wad/g' ~/RetroPie/roms/ports/Strife\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Strife\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=34/g' ~/RetroPie/roms/ports/Strife\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Strife\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_strife1-warp =' ; echo $?) == '0' ]; then
		echo 'doom_strife1-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_strife1-warp\ =.*/doom\_strife1-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/sve.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(DAZI\).sh
	sed -i 's/doom1.wad/sve.wad/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(DAZI\).sh ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/sve-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/sve.wad ~/RetroPie/roms/ports/doom/sve-warp.wad 2>/dev/null
	sed -i 's/sve.wad/sve-warp.wad/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=33/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/Strife\ Veteren\ Edition\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_sve-warp =' ; echo $?) == '0' ]; then
		echo 'doom_sve-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_sve-warp\ =.*/doom\_sve-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
fi

if [ -f ~/RetroPie/roms/ports/doom/tnt.wad ]; then
	echo "$daziSH" > ~/RetroPie/roms/ports/TNT\ \(DAZI\).sh
	sed -i 's/doom1.wad/tnt.wad/g' ~/RetroPie/roms/ports/TNT\ \(DAZI\).sh
	cp ~/RetroPie/roms/ports/TNT\ \(DAZI\).sh ~/RetroPie/roms/ports/TNT\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/TNT\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/TNT\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/TNT\ \(DAZI\).sh
	rm ~/RetroPie/roms/ports/doom/tnt-warp.wad 2>/dev/null
	ln -s ~/RetroPie/roms/ports/doom/tnt.wad ~/RetroPie/roms/ports/doom/tnt-warp.wad 2>/dev/null
	sed -i 's/tnt.wad/tnt-warp.wad/g' ~/RetroPie/roms/ports/TNT\ \(WARP\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/TNT\ \(WARP\).sh
	sed -i 's/mapNUM=1993/mapNUM=32/g' ~/RetroPie/roms/ports/TNT\ \(WARP\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=3/g' ~/RetroPie/roms/ports/TNT\ \(WARP\).sh
	# Add [to emulators.cfg]
	if [ ! $(cat /opt/retropie/configs/all/emulators.cfg | grep -q 'doom_tnt-warp =' ; echo $?) == '0' ]; then
		echo 'doom_tnt-warp = "lzdoom-dazi+warp"' >> /opt/retropie/configs/all/emulators.cfg
	else
		sed -i 's/doom\_tnt-warp\ =.*/doom\_tnt-warp\ =\ \"lzdoom-dazi+warp\"/g' /opt/retropie/configs/all/emulators.cfg
	fi
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
	sed -i 's/doomMOD1=.*/doomMOD1=~\/RetroPie\/roms\/ports\/doom\/mods\/SIGIL.zip/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	sed -i 's/episodeNUM=1993/episodeNUM=/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	sed -i 's/mapNUM=1993/mapNUM=/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	sed -i 's/skillLEVEL=1993/skillLEVEL=/g' ~/RetroPie/roms/ports/Doom\ SIGIL\ \(DAZI\).sh
	rm /dev/shm/SIGIL_v1_21.zip 2>/dev/null
	rm /dev/shm/SIGIL_v1_21 -R -f 2>/dev/null
	rm /dev/shm/__MACOSX -R -f 2>/dev/null
	
	# 0ne Humanity Template
	wget https://github.com/RapidEdwin08/dazi/raw/main/'0ne Humanity.sh' -P /dev/shm/
	mv /dev/shm/'0ne Humanity.sh' ~/RetroPie/roms/ports/0ne\ Humanity\ \(DAZI\).sh
	sed -i 's+addonDIR=~/RetroPie/roms/ports/doom/addon+#addonDIR=~/RetroPie/roms/ports/doom/addon+g' ~/RetroPie/roms/ports/0ne\ Humanity\ \(DAZI\).sh
	sed -i 's+#addonDIR=/dev/shm/addon+addonDIR=/dev/shm/addon+g' ~/RetroPie/roms/ports/0ne\ Humanity\ \(DAZI\).sh
fi

# FINISHED
dialog --no-collapse --title "GENERATE [DAZI-Templates.sh] in [../roms/ports] *COMPLETE!* " --ok-label Back --msgbox "Current [DAZI-Templates.sh] and [WARP-Templates.sh] in [../roms/ports]: $(ls ~/RetroPie/roms/ports/ | grep '(DAZI)' | sort -n && ls ~/RetroPie/roms/ports/ | grep '(WARP)' | sort -n )"  25 75

getDAZIshMENU
}

removeDAZIsh()
{
tput reset

# REMOVE DAZI Templates
rm ~/RetroPie/roms/ports/'0ne Humanity (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 2 (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 2 (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 3 (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest 3 (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Chex Quest (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom I (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom II (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom II (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom I (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom SIGIL (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom Ultimate (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Doom Ultimate (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase I (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase II (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase II (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Freedoom Phase I (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'HacX (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'HacX (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Heretic (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Heretic (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Hexen (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Hexen (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Plutonia (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Plutonia (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife Veteren Edition (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife Veteren Edition (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'Strife (WARP).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'TNT (DAZI).sh' 2>/dev/null
rm ~/RetroPie/roms/ports/'TNT (WARP).sh' 2>/dev/null

# FINISHED
dialog --no-collapse --title "REMOVE [DAZI-Templates.sh] in [../roms/ports] *COMPLETE!* " --ok-label Back --msgbox "$daziLOGO"  25 75

getDAZIshMENU
}

DMLmainMENU()
{
# Apply Custom User M0D Directory IF DEFINED
if [ ! "$alternateM0Ddir" == "" ]; then M0DdirMAIN="$alternateM0Ddir"; fi

if [ ! -d $modDIRtmpfs ]; then mkdir $modDIRtmpfs; fi
if [ ! -d $modDIRroms ]; then mkdir $modDIRroms; fi
if [ ! -d $M0DdirMAIN ]; then mkdir $M0DdirMAIN; fi

# WARN IF [..ports/doom/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/doom/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "MAKE SURE LZDOOM IS INSTALLED!"  25 75
fi
# Confirm Configurations
DMLconfCONFIG=$(dialog --stdout --no-collapse --title " [DAZI] M0D LOADER for [lzdoom] by: RapidEdwin08 [$versionDAZI]" \
	--ok-label SELECT --cancel-label "$MENUlaunchDOOM" \
	--menu "\n[$modDIRroms] FreeSpace: [$(df -h $modDIRroms |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRroms -maxdepth 1 -type f | sed 's|.*/||' | sort -n ) $(find $modDIRroms -maxdepth 1 -type l | sed 's|.*/||' | sort -n ) \n$daziHUD \n[$modDIRtmpfs] (tmpfs) FreeSpace: [$(df -h $modDIRtmpfs |awk '{print $4}' | grep -v Avail )] \n$(find $modDIRtmpfs -maxdepth 1 -type f | sed 's|.*/||' | sort -n ) $(find $modDIRtmpfs -maxdepth 1 -type l | sed 's|.*/||' | sort -n ) \n" 25 75 20 \
	1 ">< $MENUlaunchDOOM ><" \
	2 ">< LOAD   [M0D] in [$modDIRtmpfs] (TMPFS) ><" \
	3 ">< REMOVE [M0D] in [$modDIRtmpfs] (TMPFS) ><" \
	4 ">< LOAD   [M0D] in [$modDIRroms] ><" \
	5 ">< REMOVE [M0D] in [$modDIRroms] ><" \
	6 ">< SELECT Alternate [M0D] Directory for this Session ><" \
	7 ">< SELECT [WARP] and [DIFFICULTY] for [lzdoom-dazi+warp] ><" \
	8 ">< DELETE [lzdoom.ini] Configuration (RESET) ><")

if [ "$DMLconfCONFIG" == '1' ]; then
	if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then
		cat /dev/null > /dev/shm/runcommand.log
		tput reset
		exit 0
	else
		mainMENU
	fi
fi

if [ "$DMLconfCONFIG" == '2' ]; then
	currentMODdir=$M0DdirMAIN
	currentADDONdir=$modDIRtmpfs
	count=0
	M0DaddMENU
fi
if [ "$DMLconfCONFIG" == '3' ]; then
	currentADDONdir=$modDIRtmpfs
	M0DremoveMENU
fi

if [ "$DMLconfCONFIG" == '4' ]; then
	currentMODdir=$M0DdirMAIN
	currentADDONdir=$modDIRroms
	count=0
	M0DaddMENU
fi
if [ "$DMLconfCONFIG" == '5' ]; then
	currentADDONdir=$modDIRroms
	M0DremoveMENU
fi

if [ "$DMLconfCONFIG" == '6' ]; then
	# DEFAULT User M0D Directory IF [alternateM0Ddir] NOT DEFINED
	if [ "$alternateM0Ddir" == "" ]; then alternateM0Ddir=$M0DdirMAIN; fi
	userM0DdirCFG=$(dialog --stdout --no-collapse --title "               SELECT an Alternate [M0D] Directory for this Session              " \
		--ok-label OK --cancel-label BACK \
		--menu "SELECT an Alternate [M0D] Directory to Load M0Ds from for this Session \n   \nYou can Also MANUALLY EDIT [alternateM0Ddir=] @ [LINE#4] of this Script \n eg. [alternateM0Ddir=/my/mods/dir] 0r [alternateM0Ddir=] Leave BLANK \n   \n CURRENT M0D Directory: [$alternateM0Ddir]" 25 75 20 \
		1 "><  HOME  [~/]  ><" \
		2 "><  MEDIA [/media]  ><" \
		3 "><  P0RTS [~/RetroPie/roms/ports]  ><" \
		4 "><  D00M  [~/RetroPie/roms/ports/doom]  ><" \
		5 "><  DAZI  [~/RetroPie/roms/ports/doom/mods]  ><")
	# M0D DIR Confirmed - Otherwise Back to Main Menu
	if [ "$userM0DdirCFG" == '1' ]; then
		alternateM0Ddir=~
		dialog --no-collapse --title "Select an Alternate [M0D] Directory for the Current Session *COMPLETE!*" --ok-label Back --msgbox "CURRENT M0D Directory: [$alternateM0Ddir]"  25 75
		DMLmainMENU
	fi
	if [ "$userM0DdirCFG" == '2' ]; then
		alternateM0Ddir=/media
		dialog --no-collapse --title "Select an Alternate [M0D] Directory for the Current Session *COMPLETE!*" --ok-label Back --msgbox "CURRENT M0D Directory: [$alternateM0Ddir]"  25 75
		DMLmainMENU
	fi
	if [ "$userM0DdirCFG" == '3' ]; then
		alternateM0Ddir=~/RetroPie/roms
		dialog --no-collapse --title "Select an Alternate [M0D] Directory for the Current Session *COMPLETE!*" --ok-label Back --msgbox "CURRENT M0D Directory: [$alternateM0Ddir]"  25 75
		DMLmainMENU
	fi
	if [ "$userM0DdirCFG" == '4' ]; then
		alternateM0Ddir=~/RetroPie/roms/ports/doom
		dialog --no-collapse --title "Select an Alternate [M0D] Directory for the Current Session *COMPLETE!*" --ok-label Back --msgbox "CURRENT M0D Directory: [$alternateM0Ddir]"  25 75
		DMLmainMENU
	fi
	if [ "$userM0DdirCFG" == '5' ]; then
		alternateM0Ddir=~/RetroPie/roms/ports/doom/mods
		dialog --no-collapse --title "Select an Alternate [M0D] Directory for the Current Session *COMPLETE!*" --ok-label Back --msgbox "CURRENT M0D Directory: [$alternateM0Ddir]"  25 75
		DMLmainMENU
	fi
DMLmainMENU
fi

if [ "$DMLconfCONFIG" == '7' ]; then WARPmainMENU; fi

# DELETE Confirmed - Otherwise Back to Main Menu
if [ "$DMLconfCONFIG" == '8' ]; then
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

WARPmainMENU()
{
# DEFINE WARP and DIFFICULTY
userWARPcfg=$(dialog --stdout --no-collapse --title "         SELECT [WARP] and [DIFFICULTY] for [lzdoom-dazi+warp]              " \
	--ok-label OK --cancel-label BACK \
	--menu "\n        When Selecting WARP Settings @ [runcommand-onstart]:\n      Refer to the *[runcommand.info]* as your Final Indicator\n  Utilize the [ABORT] 0ption to REFRESH the [runcommand] if Needed\n[DAZI-Templates] with Pre-Defined [-warp -skill] OVERRIDE SETTINGS here\n   \nSELECT and APPLY Settings to [emulators.cfg] @ [-warp E# M# -skill S#\"] \neg. Ultimate Doom SIGIL E5M9 on Ultra-Violence [-warp  5  9 -skill  4]\n   \nCURRENT [emulators.cfg]:    [$(cat /opt/retropie/configs/ports/doom/emulators.cfg | grep '\-warp' | tail -c 22 )]\nCURRENT [runcommand.info]:  [$(cat /dev/shm/runcommand.info | grep '\-warp' | tail -c 21 )]\n   \nCURRENT [USER] SELECT Settings: -warp [$episodeNUM] [$mapNUM] -skill [$skillLEVEL]" 25 75 20 \
	1 "><  SELECT [Episode]  ><" \
	2 "><  SELECT [Map]  ><" \
	3 "><  SELECT [Difficulty]  ><" \
	4 "><  APPLY  [Episode] [Map] [Difficulty] to [emulators.cfg] ><" \
	5 "><  ABORT  [runcommand] and EXIT  ><" \
	6 "><  REFERENCES  ><")

# SELECT Setting Confirmed - Otherwise Back to Main Menu
if [ "$userWARPcfg" == '1' ]; then
	confEPISODE=$(dialog --stdout --no-collapse --title "SELECT EPISODE #" \
		--ok-label OK --cancel-label Back \
		--menu "             ? [EPISODE] ?  CURRENT USER SELECTION: [$episodeNUM]" 25 75 20 \
		0 "EPISODE [NONE] eg. D00M II" \
		1 "EPISODE [1]    eg. Knee-Deep In The Dead" \
		2 "EPISODE [2]    eg. The Shores Of Hell" \
		3 "EPISODE [3]    eg. Inferno" \
		4 "EPISODE [4]    eg. Thy Flesh Consumed" \
		5 "EPISODE [5]    eg. SIGIL" \
		6 "EPISODE [6]    eg. Heretic: Fates Path")
	
	# Confirmed - Otherwise Back to Main Menu
	if [ "$confEPISODE" == '0' ]; then episodeNUM=; fi
	if [ "$confEPISODE" == '1' ]; then episodeNUM=1; fi
	if [ "$confEPISODE" == '2' ]; then episodeNUM=2; fi
	if [ "$confEPISODE" == '3' ]; then episodeNUM=3; fi
	if [ "$confEPISODE" == '4' ]; then episodeNUM=4; fi
	if [ "$confEPISODE" == '5' ]; then episodeNUM=5; fi
	if [ "$confEPISODE" == '6' ]; then episodeNUM=6; fi
WARPmainMENU
fi

if [ "$userWARPcfg" == '2' ]; then
	confMAP=$(dialog --stdout --no-collapse --title "SELECT MAP #" \
		--ok-label OK --cancel-label Back \
		--menu "             ? [MAP] ?  CURRENT USER SELECTION: [$mapNUM]" 25 75 20 \
		1 "MAP [1]" \
		2 "MAP [2]" \
		3 "MAP [3]" \
		4 "MAP [4]" \
		5 "MAP [5]" \
		6 "MAP [6]" \
		7 "MAP [7]" \
		8 "MAP [8]" \
		9 "MAP [9]    eg. D00M I" \
		10 "MAP [10]" \
		11 "MAP [11]" \
		12 "MAP [12]" \
		13 "MAP [13]" \
		14 "MAP [14]" \
		15 "MAP [15]" \
		16 "MAP [16]" \
		17 "MAP [17]" \
		18 "MAP [18]" \
		19 "MAP [19]" \
		20 "MAP [20]" \
		21 "MAP [21]" \
		22 "MAP [22]" \
		23 "MAP [23]" \
		24 "MAP [24]" \
		25 "MAP [25]" \
		26 "MAP [26]" \
		27 "MAP [27]" \
		28 "MAP [28]" \
		29 "MAP [29]" \
		30 "MAP [30]" \
		31 "MAP [31]" \
		32 "MAP [32]    eg. D00M II" \
		33 "MAP [33]    eg. Hexen: Deathkings" \
		34 "MAP [34]    eg. Strife" \
		35 "MAP [35]    eg. HacX" \
		36 "MAP [36]" \
		37 "MAP [37]" \
		38 "MAP [38]" \
		39 "MAP [39]" \
		40 "MAP [40]    eg. Hexen" \
		41 "MAP [41]" \
		42 "MAP [42]" \
		43 "MAP [43]" \
		44 "MAP [44]" \
		45 "MAP [45]" \
		46 "MAP [46]" \
		47 "MAP [47]" \
		48 "MAP [48]" \
		49 "MAP [49]" \
		50 "MAP [50]" \
		51 "MAP [51]" \
		52 "MAP [52]" \
		53 "MAP [53]" \
		54 "MAP [54]" \
		55 "MAP [55]" \
		56 "MAP [56]" \
		57 "MAP [57]" \
		58 "MAP [58]" \
		59 "MAP [59]" \
		60 "MAP [60]    eg. Hexen: Deathkings")
	
	# Confirmed - Otherwise Back to Main Menu
	if [ "$confMAP" == '1' ]; then mapNUM=1; fi
	if [ "$confMAP" == '2' ]; then mapNUM=2; fi
	if [ "$confMAP" == '3' ]; then mapNUM=3; fi
	if [ "$confMAP" == '4' ]; then mapNUM=4; fi
	if [ "$confMAP" == '5' ]; then mapNUM=5; fi
	if [ "$confMAP" == '6' ]; then mapNUM=6; fi
	if [ "$confMAP" == '7' ]; then mapNUM=7; fi
	if [ "$confMAP" == '8' ]; then mapNUM=8; fi
	if [ "$confMAP" == '9' ]; then mapNUM=9; fi
	if [ "$confMAP" == '10' ]; then mapNUM=10; fi
	if [ "$confMAP" == '11' ]; then mapNUM=11; fi
	if [ "$confMAP" == '12' ]; then mapNUM=12; fi
	if [ "$confMAP" == '13' ]; then mapNUM=13; fi
	if [ "$confMAP" == '14' ]; then mapNUM=14; fi
	if [ "$confMAP" == '15' ]; then mapNUM=15; fi
	if [ "$confMAP" == '16' ]; then mapNUM=16; fi
	if [ "$confMAP" == '17' ]; then mapNUM=17; fi
	if [ "$confMAP" == '18' ]; then mapNUM=18; fi
	if [ "$confMAP" == '19' ]; then mapNUM=19; fi
	if [ "$confMAP" == '20' ]; then mapNUM=20; fi
	if [ "$confMAP" == '21' ]; then mapNUM=21; fi
	if [ "$confMAP" == '22' ]; then mapNUM=22; fi
	if [ "$confMAP" == '23' ]; then mapNUM=23; fi
	if [ "$confMAP" == '24' ]; then mapNUM=24; fi
	if [ "$confMAP" == '25' ]; then mapNUM=25; fi
	if [ "$confMAP" == '26' ]; then mapNUM=26; fi
	if [ "$confMAP" == '27' ]; then mapNUM=27; fi
	if [ "$confMAP" == '28' ]; then mapNUM=28; fi
	if [ "$confMAP" == '29' ]; then mapNUM=29; fi
	if [ "$confMAP" == '30' ]; then mapNUM=30; fi
	if [ "$confMAP" == '31' ]; then mapNUM=31; fi
	if [ "$confMAP" == '32' ]; then mapNUM=32; fi
	if [ "$confMAP" == '33' ]; then mapNUM=33; fi
	if [ "$confMAP" == '34' ]; then mapNUM=34; fi
	if [ "$confMAP" == '35' ]; then mapNUM=35; fi
	if [ "$confMAP" == '36' ]; then mapNUM=36; fi
	if [ "$confMAP" == '37' ]; then mapNUM=37; fi
	if [ "$confMAP" == '38' ]; then mapNUM=38; fi
	if [ "$confMAP" == '39' ]; then mapNUM=39; fi
	if [ "$confMAP" == '40' ]; then mapNUM=40; fi
	if [ "$confMAP" == '41' ]; then mapNUM=41; fi
	if [ "$confMAP" == '42' ]; then mapNUM=42; fi
	if [ "$confMAP" == '43' ]; then mapNUM=43; fi
	if [ "$confMAP" == '44' ]; then mapNUM=44; fi
	if [ "$confMAP" == '45' ]; then mapNUM=45; fi
	if [ "$confMAP" == '46' ]; then mapNUM=46; fi
	if [ "$confMAP" == '47' ]; then mapNUM=47; fi
	if [ "$confMAP" == '48' ]; then mapNUM=48; fi
	if [ "$confMAP" == '49' ]; then mapNUM=49; fi
	if [ "$confMAP" == '50' ]; then mapNUM=50; fi
	if [ "$confMAP" == '51' ]; then mapNUM=51; fi
	if [ "$confMAP" == '52' ]; then mapNUM=52; fi
	if [ "$confMAP" == '53' ]; then mapNUM=53; fi
	if [ "$confMAP" == '54' ]; then mapNUM=54; fi
	if [ "$confMAP" == '55' ]; then mapNUM=55; fi
	if [ "$confMAP" == '56' ]; then mapNUM=56; fi
	if [ "$confMAP" == '57' ]; then mapNUM=57; fi
	if [ "$confMAP" == '58' ]; then mapNUM=58; fi
	if [ "$confMAP" == '59' ]; then mapNUM=59; fi
	if [ "$confMAP" == '60' ]; then mapNUM=60; fi
WARPmainMENU
fi

if [ "$userWARPcfg" == '3' ]; then
	confSKILL=$(dialog --stdout --no-collapse --title "SELECT DIFFICULTY #" \
		--ok-label OK --cancel-label Back \
		--menu "             ? [DIFFICULTY] ?  CURRENT USER SELECTION: [$skillLEVEL]" 25 75 20 \
		1 "DIFFICULTY [1] Im too young to die" \
		2 "DIFFICULTY [2] Hey, not too rough." \
		3 "DIFFICULTY [3] Hurt me plenty." \
		4 "DIFFICULTY [4] Ultra-Violence." \
		5 "DIFFICULTY [5] Nightmare!")
	
	# Confirmed - Otherwise Back to Main Menu
	if [ "$confSKILL" == '1' ]; then skillLEVEL=1; fi
	if [ "$confSKILL" == '2' ]; then skillLEVEL=2; fi
	if [ "$confSKILL" == '3' ]; then skillLEVEL=3; fi
	if [ "$confSKILL" == '4' ]; then skillLEVEL=4; fi
	if [ "$confSKILL" == '5' ]; then skillLEVEL=5; fi
WARPmainMENU
fi

if [ "$userWARPcfg" == '4' ]; then
	# Prepare WARP and DIFFICULTY Settings For [lzdoom-dazi+warp]
	if [ "$mapNUM" == "" ]; then mapNUM=1; fi # Set Map [1] if NOT DEFINED
	if [ "$skillLEVEL" == "" ]; then skillLEVEL=3; fi # Set DEFAULT DIFFICULTY [Hurt me plenty] if NOT DEFINED
	sed -i "s/-warp.*/-warp\ $episodeNUM\ $mapNUM\ -skill\ $skillLEVEL\"/g" /opt/retropie/configs/ports/doom/emulators.cfg #Update [-warp*] in [emulators.cfg]
	dialog --no-collapse --title "APPLY [Episode] [Map] [Difficulty] Settings to [emulators.cfg] *COMPLETE!*" --ok-label Back --msgbox "\n   \nCURRENT [USER] SELECT Settings: -warp [$episodeNUM] [$mapNUM] -skill [$skillLEVEL]\n   \nCURRENT [emulators.cfg]:    [$(cat /opt/retropie/configs/ports/doom/emulators.cfg | grep '\-warp' | tail -c 22 )]\nCURRENT [runcommand.info]:  [$(cat /dev/shm/runcommand.info | grep '\-warp' | tail -c 21 )]"  25 75
	WARPmainMENU
fi

# QUIT
if [ "$userWARPcfg" == '5' ]; then
	# kill instances of runcommand scripts
	PIDrunncommandSH=$(ps -eaf | grep "runcommand.sh" | awk '{print $2}')
	kill $PIDrunncommandSH > /dev/null 2>&1
	tput reset
	exit 0
fi

# REFERENCES
if [ "$userWARPcfg" == '6' ]; then
	dialog --no-collapse --title "[WARP] + [DIFFICULTY] SETTINGS REFERENCES" --ok-label Back --msgbox "$doomWARPdiff $(cat /opt/retropie/configs/ports/doom/emulators.cfg | grep 'default =')"  25 75
	WARPmainMENU
fi

DMLmainMENU
}

M0DremoveMENU()
{
tput reset
# =====================================
# Check if NO Files/Folders
if [ "$(ls -1 $currentADDONdir)" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$currentADDONdir] FreeSpace: [$(df -h $currentADDONdir |awk '{print $4}' | grep -v Avail )] \n"  25 75
	if [ $currentADDONdir == $modDIRtmpfs ] || [ $currentADDONdir == $modDIRroms ]; then
		DMLmainMENU
	else
		# Go up a Directory
		currentADDONdir=$(dirname $currentADDONdir)
		M0DremoveMENU
	fi
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
done < <( ls -1 $currentADDONdir )
FILE=$(dialog --title "Remove M0D from $currentADDONdir" --ok-label SELECT --cancel-label BACK --menu "[$currentADDONdir] FreeSpace: [$(df -h $currentADDONdir |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $currentADDONdir | sort -n )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(ls -1 $currentADDONdir | sed -n "`echo "$FILE p" | sed 's/ //'`")
	# Change to Sub-Directory IF NOT a FILE
	if [ -d "$currentADDONdir/$selectFILE" ]; then
		currentADDONdir="$currentADDONdir/$selectFILE"
		M0DremoveMENU
	else
		# Perform desired Action for selectFILE
		rm "$currentADDONdir/$selectFILE"
	fi
	# Check if NO Files/Folders
	if [ "$(ls -1 $currentADDONdir)" == '' ]; then
		dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$currentADDONdir] FreeSpace: [$(df -h $currentADDONdir |awk '{print $4}' | grep -v Avail )] \n"  25 75
		# Back to Menu IF in MAIN DIR
		if [ $currentADDONdir == $modDIRtmpfs ] || [ $currentADDONdir == $modDIRroms ]; then
			DMLmainMENU
		else
			# Go up a Directory
			currentADDONdir=$(dirname $currentADDONdir)
			M0DremoveMENU
		fi
	fi
	M0DremoveMENU
fi

# Go up Directory IF NO INPUT + NOT MAIN DIRs
if [ ! $currentADDONdir == $modDIRtmpfs ] && [ ! $currentADDONdir == $modDIRroms ]; then
	# Go up Directory Minus selectFILE
	currentADDONdir=$(dirname $currentADDONdir)
	M0DremoveMENU
fi

DMLmainMENU
}

M0DaddMENU()
{
tput reset
count=0
# =====================================
# DO NOT DEFINE R00T [ / ] FOR THE M0D DIRECTORY!
if [ "$alternateM0Ddir" == '/' ]; then
	dialog --no-collapse --title "  CAN NOT DEFINE *R00T* [ / ] FOR THE [alternateM0Ddir] DIRECTORY!   " --ok-label CONTINUE --msgbox "        SELECT an Alternate [M0D] Directory for this Session \n \nYou can Also MANUALLY EDIT [alternateM0Ddir=] @ [LINE#4] of this Script \n eg. [alternateM0Ddir=/my/mods/dir] 0r [alternateM0Ddir=] Leave BLANK \n"  25 75
	DMLmainMENU
fi

# Back to Menu IF in R00T DIR - Failsafe to Prevent getting Stuck in Endless M0D Loader [Back] L00P in Menu when '/' is INCLUDED/ at END/ of [alternateM0Ddir/] PATH/
if [ $currentMODdir == '/' ]; then DMLmainMENU; fi

# Check if NO Files/Folders
if [ "$(ls -1 $currentMODdir)" == '' ]; then
	dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$currentADDONdir] FreeSpace: [$(df -h $currentADDONdir |awk '{print $4}' | grep -v Avail )] \n"  25 75
	if [ $currentMODdir == $M0DdirMAIN ]; then
		DMLmainMENU
	else
		# Go up a Directory
		currentMODdir=$(dirname $currentMODdir)
		M0DaddMENU
	fi
fi

let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
done < <( ls -1 $currentMODdir )
FILE=$(dialog --title "Load M0D from $currentMODdir" --ok-label SELECT --cancel-label BACK --menu "[$currentADDONdir] FreeSpace: [$(df -h $currentADDONdir |awk '{print $4}' | grep -v Avail )] \n$(ls -1 $currentADDONdir | sort -n )\n" 25 75 20 "${W[@]}" 3>&2 2>&1 1>&3  </dev/tty > /dev/tty) # show dialog and store output
#clear
tput reset
#if [ $? -eq 0 ]; then # Exit with OK
if [ ! "$FILE" == '' ]; then
	selectFILE=$(ls -1 $currentMODdir | sed -n "`echo "$FILE p" | sed 's/ //'`")
	# Change to Sub-Directory IF NOT a FILE
	if [ -d "$currentMODdir/$selectFILE" ]; then
		currentMODdir="$currentMODdir/$selectFILE"
		M0DaddMENU
	else
		# Perform desired Action for selectFILE - ZIPs get Extracted - TXTs get READ - Create SymbolicLinks for all other file types
		if [[ "$selectFILE" == *".zip" ]] || [[ "$selectFILE" == *".ZIP" ]]; then
			unzip -qq -o "$currentMODdir/$selectFILE" -d "$currentADDONdir"
		elif [[ "$selectFILE" == *".txt" ]] || [[ "$selectFILE" == *".TXT" ]]; then
			readTEXT=$(cat "$currentMODdir/$selectFILE")
			dialog --no-collapse --title "  [$selectFILE]   " --ok-label CONTINUE --msgbox "$readTEXT"  25 75
			M0DaddMENU
		else
			# Count Current Files/Links in ADDONS - Update Count
			if [ ! "$(find $currentADDONdir -maxdepth 1 -type f | wc -l )" == '0' ] || [ ! "$(find $currentADDONdir -maxdepth 1 -type l | wc -l )" == '0' ]; then count=$(( $count + $(find $currentADDONdir -maxdepth 1 -type f | wc -l ) + $(find $currentADDONdir -maxdepth 1 -type l | wc -l ) )); fi
			count=$(( $count + 1 ))
			# cp "$currentMODdir/$selectFILE" $currentADDONdir #Too Slow - Wears on Storage - Size Limitations
			ln -s "$currentMODdir/$selectFILE" "$currentADDONdir/0"$count"_"$selectFILE""
		fi
		dialog --no-collapse --title "  M0D Added: [$selectFILE]   " --ok-label CONTINUE --msgbox "[$currentADDONdir] FreeSpace: [$(df -h $currentADDONdir |awk '{print $4}' | grep -v Avail )] \n \n$(ls -1 $currentADDONdir | sort -n )\n"  25 75
	fi
	# Check if NO Files/Folders
	if [ "$(ls -1 $currentMODdir)" == '' ]; then
		dialog --no-collapse --title "  NO FILES FOUND   " --ok-label CONTINUE --msgbox "[$currentADDONdir] FreeSpace: [$(df -h $currentADDONdir |awk '{print $4}' | grep -v Avail )] \n"  25 75
		# Back to Menu IF in MAIN DIR
		if [ $currentMODdir == $M0DdirMAIN ]; then
			DMLmainMENU
		else
			# Go up a Directory
			currentMODdir=$(dirname $currentMODdir)
			M0DaddMENU
		fi
	fi
	M0DaddMENU
fi

# Go up Directory IF NO INPUT + NOT MAIN ADDON DIRs
if [ ! $currentMODdir == $M0DdirMAIN ]; then
	# Go up Directory Minus selectFILE
	currentMODdir=$(dirname $currentMODdir)
	M0DaddMENU
fi

DMLmainMENU
}

srb2ADDONSmenu()
{
# Confirm Configurations
srb2CONFIG=$(dialog --stdout --no-collapse --title "    MANAGE  [srb2] + [srb2kart] AddOns" \
	--ok-label SELECT --cancel-label "BACK" \
	--menu "   [Sonic Robo Blast 2] Already Has AddOn Management Built-In \n[dazi] can SET [SRB2] CUSTOM AddOns Directory to [..ports/doom/mods/]\n$daziHUDsrb2 \nCURRENT $(cat /opt/retropie/configs/ports/srb2/config.cfg | grep 'addons_folder' ) \nCURRENT $(cat /opt/retropie/configs/ports/srb2kart/kartconfig.cfg | grep 'addons_folder' )" 25 75 20 \
	1 ">< SET [SRB2]     AddOns Directory to [..doom/mods/srb2] ><" \
	2 ">< SET [SRB2KART] AddOns Directory to [..doom/mods/srb2kart] ><" \
	3 ">< SET [SRB2]     AddOns Directory to [DEFAULT] ><" \
	4 ">< SET [SRB2KART] AddOns Directory to [DEFAULT] ><" \
	5 ">< VIEW   Contents of [SRB2KART] DOWNLOAD Directory ><" \
	6 ">< DELETE Contents of [SRB2KART] DOWNLOAD Directory ><" \
	7 ">< REFERENCES [Sonic Robo Blast 2] ><")

if [ "$srb2CONFIG" == '1' ]; then
	# SKIP IF [cfg] N0T Found 
	if [ ! -f /opt/retropie/configs/ports/srb2/config.cfg ]; then
		dialog --no-collapse --title "***N0TICE*** [~/.srb2/config.cfg] NOT FOUND!" --ok-label MENU --msgbox "MAKE SURE [SRB2] IS INSTALLED! \nIF ALREADY INSTALLED MAKE SURE YOU RUN IT AT LEAST ONCE TO GENERATE THE [.CFG] FILE"  25 75
		srb2ADDONSmenu
	fi
	# Apply CUSTOM AddOns Directory [srb2] CFG
	if [ ! -d ~/RetroPie/roms/ports/doom/mods/srb2 ]; then mkdir ~/RetroPie/roms/ports/doom/mods/srb2; fi
	sed -i "s/addons_folder.*/addons_folder\ \"\/home\/$USER\/RetroPie\/roms\/ports\/doom\/mods\/srb2\"/g" /opt/retropie/configs/ports/srb2/config.cfg
	sed -i 's/addons_option.*/addons_option\ \"CUSTOM\"/g' /opt/retropie/configs/ports/srb2/config.cfg
	dialog --no-collapse --title "SET [SRB2] AddOns Directory to [..doom/mods/srb2] *COMPLETE!*" --ok-label Back --msgbox "$srb2FILES"  25 75
	srb2ADDONSmenu
fi
	

if [ "$srb2CONFIG" == '2' ]; then
	# SKIP IF [cfg] N0T Found 
	if [ ! -f /opt/retropie/configs/ports/srb2kart/kartconfig.cfg ]; then
		dialog --no-collapse --title "***N0TICE*** [~/.srb2kart/kartconfig.cfg] NOT FOUND!" --ok-label MENU --msgbox "MAKE SURE [SRB2KART] IS INSTALLED! \nIF ALREADY INSTALLED MAKE SURE YOU RUN IT AT LEAST ONCE TO GENERATE THE [.CFG] FILE"  25 75
		srb2ADDONSmenu
	fi
	# Apply CUSTOM AddOns Directory [srb2kart] CFG - Create Symbolic Link to DOWNLOAD in CUSTOM Directory
	if [ ! -d ~/RetroPie/roms/ports/doom/mods/srb2kart ]; then mkdir ~/RetroPie/roms/ports/doom/mods/srb2kart; fi
	if [ ! -d ~/RetroPie/roms/ports/doom/mods/srb2kart/DOWNLOAD ]; then ln -s /opt/retropie/configs/ports/srb2kart/DOWNLOAD ~/RetroPie/roms/ports/doom/mods/srb2kart/DOWNLOAD; fi
	sed -i "s/addons_folder.*/addons_folder\ \"\/home\/$USER\/RetroPie\/roms\/ports\/doom\/mods\/srb2kart\"/g" /opt/retropie/configs/ports/srb2kart/kartconfig.cfg
	sed -i 's/addons_option.*/addons_option\ \"CUSTOM\"/g' /opt/retropie/configs/ports/srb2kart/kartconfig.cfg
	dialog --no-collapse --title "SET [SRB2KART] AddOns Directory to [..doom/mods/srb2kart] *COMPLETE!*" --ok-label Back --msgbox "$srb2FILES"  25 75
	srb2ADDONSmenu
fi

if [ "$srb2CONFIG" == '3' ]; then
	# SKIP IF [cfg] N0T Found 
	if [ ! -f /opt/retropie/configs/ports/srb2/config.cfg ]; then
		dialog --no-collapse --title "***N0TICE*** [~/.srb2/config.cfg] NOT FOUND!" --ok-label MENU --msgbox "MAKE SURE [SRB2] IS INSTALLED! \nIF ALREADY INSTALLED MAKE SURE YOU RUN IT AT LEAST ONCE TO GENERATE THE [.CFG] FILE"  25 75
		srb2ADDONSmenu
	fi
	# Apply DEFAULT AddOns Directory [srb2] CFG
	if [ ! -d ~/RetroPie/roms/ports/doom/mods/srb2 ]; then mkdir ~/RetroPie/roms/ports/doom/mods/srb2; fi
	sed -i "s/addons_folder.*/addons_folder\ \"\/opt\/retropie\/configs\/ports\/srb2\/addon\"/g" /opt/retropie/configs/ports/srb2/config.cfg
	sed -i 's/addons_option.*/addons_option\ \"CUSTOM\"/g' /opt/retropie/configs/ports/srb2/config.cfg
	dialog --no-collapse --title "SET [SRB2] AddOns Directory to [DEFAULT] *COMPLETE!*" --ok-label Back --msgbox "$srb2FILES"  25 75
	srb2ADDONSmenu
fi
	

if [ "$srb2CONFIG" == '4' ]; then
	# SKIP IF [cfg] N0T Found 
	if [ ! -f /opt/retropie/configs/ports/srb2kart/kartconfig.cfg ]; then
		dialog --no-collapse --title "***N0TICE*** [~/.srb2kart/kartconfig.cfg] NOT FOUND!" --ok-label MENU --msgbox "MAKE SURE [SRB2KART] IS INSTALLED! \nIF ALREADY INSTALLED MAKE SURE YOU RUN IT AT LEAST ONCE TO GENERATE THE [.CFG] FILE"  25 75
		srb2ADDONSmenu
	fi
	# Apply DEFAULT AddOns Directory [srb2kart] CFG - Remove Symbolic Link to DOWNLOAD in CUSTOM Directory
	if [ ! -d ~/RetroPie/roms/ports/doom/mods/srb2kart ]; then mkdir ~/RetroPie/roms/ports/doom/mods/srb2kart; fi
	sed -i "s/addons_folder.*/addons_folder\ \"\/opt\/retropie\/configs\/ports\/srb2kart\/addon\"/g" /opt/retropie/configs/ports/srb2kart/kartconfig.cfg
	sed -i 's/addons_option.*/addons_option\ \"CUSTOM\"/g' /opt/retropie/configs/ports/srb2kart/kartconfig.cfg
	if [ ! -d ~/RetroPie/roms/ports/doom/mods/srb2kart/DOWNLOAD ]; then rm ~/RetroPie/roms/ports/doom/mods/srb2kart/DOWNLOAD; fi
	dialog --no-collapse --title "SET [SRB2KART] AddOns Directory to [DEFAULT] *COMPLETE!*" --ok-label Back --msgbox "$srb2FILES"  25 75
	srb2ADDONSmenu
fi

if [ "$srb2CONFIG" == '5' ]; then
	# VIEW Contents Confirmed
	if [ ! -d /opt/retropie/configs/ports/srb2kart/DOWNLOAD ]; then
		dialog --no-collapse --title "***N0TICE*** [/opt/retropie/configs/ports/srb2kart/DOWNLOAD] NOT FOUND!" --ok-label MENU --msgbox "$daziHUDsrb2"  25 75
	else
		dialog --no-collapse --title " CONTENTS [/opt/retropie/configs/ports/srb2kart/DOWNLOAD]:" --ok-label Back --msgbox "$daziHUDsrb2 $(ls /opt/retropie/configs/ports/srb2kart/DOWNLOAD | sort -n) "  25 75
	fi
	srb2ADDONSmenu
fi

if [ "$srb2CONFIG" == '6' ]; then
	SRB2confDELETEdl=$(dialog --stdout --no-collapse --title " DELETE [/opt/retropie/configs/ports/srb2kart/DOWNLOAD] Directory " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  DELETE [SRB2KART] DOWNLOAD Directory ><" \
		3 "><  BACK  ><")
	# DELETE Confirmed - Otherwise Back to Main Menu
	if [ "$SRB2confDELETEdl" == '1' ]; then
		rm /opt/retropie/configs/ports/srb2kart/DOWNLOAD -R -f > /dev/null 2>&1
		mkdir /opt/retropie/configs/ports/srb2kart/DOWNLOAD > /dev/null 2>&1
		dialog --no-collapse --title " DELETE [SRB2KART] DOWNLOAD Directory *COMPLETE!*" --ok-label Back --msgbox "$daziHUDsrb2 $srb2FILES"  25 75
		srb2ADDONSmenu
	fi
srb2ADDONSmenu
fi

if [ "$srb2CONFIG" == '7' ]; then
	dialog --no-collapse --title "   [Sonic Robo Blast 2] REFERENCES" --ok-label Back --msgbox "$daziHUDsrb2 $srb2FILES"  25 75
	srb2ADDONSmenu
fi

tput reset
mainMENU
}

# Parameter [clean] determines Cleanup of addonDIR - Called by [runcommand-onend.sh]
if [ "$1" == "clean" ]; then
	# CASE#1: [runcommand.log] FILLED = ROM was Launched/Played -> DELETE the [addonDIR]
	# CASE#2: [runcommand.log] BLANK = EXIT WITHOUT LAUNCHING -> KEEP the [addonDIR]
	# USE CASE#2 to Pre-Load a M0D in [addonDIR] BY SELECTING [EXIT WITHOUT LAUNCHING]
	if [ ! "$(cat /dev/shm/runcommand.log)" == "" ]; then
		# Settings File determines Actions - Anything 0ther than 1,2,3 will do Nothing 0ther than Logging and Exit
		if [ -f /opt/retropie/configs/ports/doom/lzdoom-dazi.clean ]; then
			if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == "0" ]; then currentCLEANcfg=[DISABLED]; fi
			if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == '1' ]; then
				rm "$modDIRtmpfs" -R -f && mkdir "$modDIRtmpfs" > /dev/null 2>&1
				currentCLEANcfg=[$modDIRtmpfs]
			fi
			if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == '2' ]; then
				rm "$modDIRroms" -R -f && mkdir "$modDIRroms" > /dev/null 2>&1
				currentCLEANcfg=[$modDIRroms]
			fi
			if [ "$(cat /opt/retropie/configs/ports/doom/lzdoom-dazi.clean)" == '3' ]; then
				rm "$modDIRtmpfs" -R -f && mkdir "$modDIRtmpfs" > /dev/null 2>&1
				rm "$modDIRroms" -R -f && mkdir "$modDIRroms" > /dev/null 2>&1
				currentCLEANcfg=[$modDIRtmpfs]+[$modDIRroms]
			fi
			echo "[dazi-mod-loader] CLEAN UP $currentCLEANcfg at [runcommand-onend]" >> /dev/shm/runcommand.log
		fi
	fi
	tput reset
	exit 0
fi

# Location of Script determines Menu Launched
if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then
	DMLmainMENU
else
	mainMENU
fi

if [ "$0" == "/opt/retropie/configs/ports/doom/lzdoom-dazi.sh" ]; then cat /dev/null > /dev/shm/runcommand.log; fi
tput reset
exit 0
