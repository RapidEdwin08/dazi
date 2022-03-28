# D00M Addon ZIP Integration (DAZI)  
Integration of D00M-M0D.ZIP files into RetroPie.  
Additionally make use of the *Runcommand Launch Menu* to Pre-Load D00M M0Ds.  
**Press [A] to Configure** -> **EXIT WITHOUT LAUNCHING** to Pre-Load One *or MORE* D00M M0Ds.  
NOTE: The **Runcommand Launch Menu** needs to be **ENABLED**  

**HOW DOES IT WORK?**  
[DAZI-Templates.sh] will Extract [D00M-M0D.ZIPs] into [/dev/shm/addon]  
[lzdoom-dazi] Entry in [emulators.cfg] will point to [/dev/shm/addon/*]  

**HOW TO USE:**  
Place your [D00M-M0D] FILEs into a [.ZIP] in [..roms/ports/doom/mods/*]  
Replace all [D00M.sh] Scripts with [DAZI-Templates.sh] in [/roms/ports]  
CHOOSE [lzdoom-dazi] D00M P0RT to RUN [DAZI-Template.sh] + [*.ZIPs]  

## INSTALLATION  

 Can be ran manually from any directory:  
```bash
cd ~
git clone https://github.com/RapidEdwin08/dazi.git
sudo chmod 755 ~/dazi/lzdoom-dazi.sh
cd ~/dazi && ./lzdoom-dazi.sh
```
0r can be ran from retropiemenu:  

```bash
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.sh -P ~/RetroPie/retropiemenu
```

0ptionally you can Add an Entry and Icon to your retropiemenu [gamelist.xml]:  
```bash
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.png -P ~/RetroPie/retropiemenu/icons
```
Example Entry:  
```
	<game>
		<path>./lzdoom-dazi.sh</path>
		<name>DAZI [lzdoom]</name>
		<desc>INSTALL/REMOVE [lzdoom-dazi] for [RetroPie].</desc>
		<image>/home/pi/RetroPie/retropiemenu/icons/lzdoom-dazi.png</image>
	</game>
```
## REFERENCES  

PLACE YOUR [D00M-M0D] FILES INTO A [D00M-M0D.ZIP]  
NAME THEM ACCORDINGLY IF A PARTICULAR L0ADING 0RDER IS NEEDED  

      # EXAMPLE [D00M-M0D.ZIP] CONTENTS #  
      ./D00M-M0D.ZIP/01-FileToLoad.wad  
      ./D00M-M0D.ZIP/02-FileToLoad.deh  
      ./D00M-M0D.ZIP/03-FileToLoad.pk3  

MODIFY [DAZI-Template.sh] TO INCLUDE YOUR [IWAD] + [D00M-M0D.ZIP]  
0ptional D00M-M0D.ZIP Entry Available if needed  

    # EXAMPLE [DAZI-Template.sh] CONTENTS #  
      doomWAD=~/RetroPie/roms/ports/doom/doom2.wad  
      modZIP=~/RetroPie/roms/ports/doom/mods/BrutalDoom.zip  
      optionalZIP=~/RetroPie/roms/ports/doom/mods/HellOnEarthStarterPack.zip  

*HOW TO PRE-LOAD D00M M0Ds WITH [DAZI] FOR 0THER ROMs:*  
Select and Load a D00M-MOD using the [DAZI-Template.sh]  
PRESS [A] BUTTON TO CONFIGURE **(Before the ROM Loads)**  
** [EXIT WITHOUT LAUNCHING] **  
The Last D00M-M0D Selected will Still be Loaded in [/dev/shm/addon]  
Now Select any 0ther Desired D00M R0M and Launch with [lzdoom-dazi]  
