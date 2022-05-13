#!/usr/bin/env bash
versionDAZI=202205

# [dazi-mod-loader.sh]
# Should be placed in: [/opt/retropie/configs/ports/doom]
# For use with [runcommand-onstart.sh]: 
# if [[ \"\$2\" == *\"lzdoom-addon\"* ]] || [[ \"\$2\" == *\"lzdoom-dazi\"* ]]; then echo \"\$3\" > /dev/shm/runcommand.log && sudo /home/$USER/RetroPie-Setup/retropie_packages.sh retropiemenu launch \"/opt/retropie/configs/ports/doom/dazi-mod-loader.sh\" </dev/tty > /dev/tty; fi #For Use With [lzdoom-dazi] + [ExitWithoutLaunching] #Line Should be LAST

daziLOGO=$(
#echo ""
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
#echo ""
#echo "       ------------------------------------------------------- "
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

modDIRzips=~/RetroPie/roms/ports/doom/mods/
modDIRroms=~/RetroPie/roms/ports/doom/addon/
modDIRtmpfs=/dev/shm/addon/

zdoomCFGrp=/opt/retropie/configs/ports/doom/lzdoom.ini
zdoomCFGroms=~/RetroPie/roms/ports/doom/lzdoom.ini

launchDOOM=$(cat /dev/shm/runcommand.log | sed 's/.*\///')
MENUlaunchDOOM="LAUNCH $launchDOOM"
if [[ "$launchDOOM" == '' ]]; then MENUlaunchDOOM=CONTINUE; fi

DMLmainMENU()
{
if [ ! -d $modDIRtmpfs ]; then mkdir $modDIRtmpfs; fi
if [ ! -d $modDIRroms ]; then mkdir $modDIRroms; fi
if [ ! -d $modDIRzips ]; then mkdir $modDIRzips; fi

# WARN IF [..ports/doom/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/doom/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/doom/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "$daziLOGO"  25 75
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
	cat /dev/null > /dev/shm/runcommand.log
	tput reset
	exit 0
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

# QUIT if N0T Confirmed
if [ "$DMLconfCONFIG" == '' ]; then
	cat /dev/null > /dev/shm/runcommand.log
	tput reset
	exit 0
fi

cat /dev/null > /dev/shm/runcommand.log
tput reset
exit 0
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

# Main Menu
DMLmainMENU

cat /dev/null > /dev/shm/runcommand.log
tput reset
exit 0
