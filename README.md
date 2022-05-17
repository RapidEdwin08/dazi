# D00M Addon ZIP Integration (DAZI)  
![lzdoom-dazi.png](https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.png)  

Integration of D00M-M0D.ZIP files into RetroPie.  
D00M M0D Loader Menu can be Launched from anywhere or Installed.  
Additionally make use of the *Runcommand Launch Menu* to Pre-Load D00M M0Ds.  
**Press [A] to Configure** -> **EXIT WITHOUT LAUNCHING** to Pre-Load One *or MORE* D00M M0Ds.  

**Before you get started:**  
**lzdoom** should be **INSTALLED**  
The **Runcommand Launch Menu** should be **ENABLED**  
Place your **[M0D].ZIP/PK3/PK7** Files in: **~/RetroPie/roms/ports/doom/mods/***  

**HOW DOES IT WORK?**  
[DAZI-Templates.sh] will Extract [D00M-M0D.ZIPs] into [/dev/shm/addon]  
[lzdoom-dazi] Entry in [emulators.cfg] will point to [/dev/shm/addon/*]  

**HOW TO PRE-LOAD D00M M0Ds WITH [DAZI] FOR 0THER ROMs [0PTION 1]**  
[dazi-mod-loader] Menu is Included for use with [lzdoom-addon]/[lzdoom-dazi]  
Use [dazi-mod-loader] Menu from this Script directly, 0r *Install* it and...  
Configure the Menu to *Always Load* when *[lzdoom-addon]/[lzdoom-dazi]* is Launched  

**HOW TO PRE-LOAD D00M M0Ds WITH [DAZI] FOR 0THER ROMs [0PTION 2]**  
Select and Load a D00M-MOD using the [DAZI-Template.sh]  
PRESS [A] BUTTON TO CONFIGURE *(Before the ROM Loads)*  
** [EXIT WITHOUT LAUNCHING] **  
The Last D00M-M0D Selected will Still be Loaded in [/dev/shm/addon]  
Now Select any 0ther Desired D00M R0M and Launch with [lzdoom-dazi]  

## INSTALLATION  

Can be ran from retropiemenu:  

```bash
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.sh -P ~/RetroPie/retropiemenu
```

0R Can be ran manually from any directory:  
```bash
cd ~
git clone https://github.com/RapidEdwin08/dazi.git
sudo chmod 755 ~/dazi/lzdoom-dazi.sh
cd ~/dazi && ./lzdoom-dazi.sh
```

0ptionally you can Add an Entry and Icon to your retropiemenu [gamelist.xml]:  
```bash
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.png -P ~/RetroPie/retropiemenu/icons
```
Example Entry:  
```
	<game>
		<path>./lzdoom-dazi.sh</path>
		<name>[lzdoom] DAZI</name>
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
0ptional D00M-M0D Entries Available if needed  

    # EXAMPLE [DAZI-Template.sh] CONTENTS #  
      doomWAD=~/RetroPie/roms/ports/doom/doom2.wad  
      doomM0D=~/RetroPie/roms/ports/doom/mods/SIGIL.zip 
      doomM0D2=~/RetroPie/roms/ports/doom/mods/WOSHUD.pk3 

SYMBOLIC LINKS for [doom.wads]:  
Use To Differentiate Which ZDoom AddOn Directory to Select via Emulator  
eg. [lzdoom-dazi] VS [lzdoom-addon]  

The [lzdoom-dazi] Entry in [emulators.cfg] refers to [/dev/shm/addon/]  
The [lzdoom-addon] Entry in [emulators.cfg] refers to [/roms/ports/addon/]  
We may want to Differentiate the x2 Emulators when using AddOns  

Normally we would just [Select Emulator for ROM] from the [runcommand]  
But D00M M0Ds use the same [doom.wad] as the [ROM] repeatedly, meaning  
[Select Emulator for ROM] will APPLY TO ALL M0Ds using that [doom.wad]  

We can Create Symbolic Links to [doom.wads] using Unique names, then...  
Add [Unique.wads] into [LargeM0D.sh] scripts that need [lzdoom-addon]  
eg. WADFile: [doom2.wad]  <->  SymbolicLink: [doom2-addon.wad]  

    # EXAMPLE [DAZI-Template.sh] CONTENTS with SYMBOLIC LINK [doom2-addon.wad]#  
      doomWAD=~/RetroPie/roms/ports/doom/doom2-addon.wad 
      doomM0D=~/RetroPie/roms/ports/doom/mods/Brutalv21ArthursEdition.pk3 

**TIPs:**  
*ZIPs are 0ptional and can be usefull for Smaller M0Ds with more than 5 Files to load*  
*LARGER M0D.ZIPs may EXCEED the Size Limitation of [/dev/shm/addon/*]*  
*Recommend avoid using ZIPs for LARGE M0Ds that may EXCEED (tmpfs)*  
*DAZI will create Symbolic Links in the AddOn DIR to all Files that are NOT ZIPs*  
