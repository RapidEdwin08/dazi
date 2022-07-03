# D00M Addon ZIP Integration (DAZI)  
![lzdoom-dazi.png](https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.png)  

Integration of D00M-M0D.ZIP files into RetroPie.  
Includes D00M M0D Loader Menu that can be Launched from anywhere or Installed.  
Additionally make use of the *Runcommand Launch Menu* to Pre-Load D00M M0Ds.  
**Press [A] to Configure** -> **EXIT WITHOUT LAUNCHING** to Pre-Load One *or MORE* D00M M0Ds.  
Additionally Manage [srb2] and [srb2kart] AddOns along with D00M M0Ds.  

**Before you get started:**  
**lzdoom** should be **INSTALLED**  
The **Runcommand Launch Menu** should be **ENABLED**  
Place your **[M0D].ZIP/PK3/PK7** Files in: **~/RetroPie/roms/ports/doom/mods/***  

**HOW DOES IT WORK?**  
Use [DAZI] to Extract [ZIPs] and Load [M0Ds] into Doom [AddOnDIRs]  
[lzdoom-addon] Loads M0Ds from ADDON [..roms/ports/doom/addon/*]  
[lzdoom-dazi]  Loads M0Ds from TMPFS [/dev/shm/addon/*]  
[lzdoom-dazi+] Loads M0Ds from BOTH  [TMPFS+ADDON] in that 0rder  

**HOW TO LOAD M0Ds:**  
Place [D00M-M0D] FILEs [WAD/PK3/PK7/ZIPs] in [..roms/ports/doom/mods/*]  
Use [dazi-mod-loader] to Load M0Ds for [lzdoom-addon] or [lzdoom-dazi]  
Alternatively use runcommand [Exit-Without-Launching] to Pre-Load M0Ds  

**HOW CREATE ROM ENTRIES FOR D00M M0Ds:**  
Create a [D00M-M0D.sh] based on a [DAZI-Template.sh] in [/roms/ports]  
ADD [doomMOD#s] to [D00M-M0D.sh] and MODIFY [addonDIR] if needed  
RUN [lzdoom-dazi] or [lzdoom-addon] based on the [D00M-M0D.sh] addonDIR  

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
	EXAMPLE [D00M-M0D.ZIP] CONTENTS  
	./D00M-M0D.ZIP/01-FileToLoad.wad  
	./D00M-M0D.ZIP/02-FileToLoad.pk3  
	./D00M-M0D.ZIP/03-FileToLoad.pk7  

MODIFY [DAZI-Template.sh] TO INCLUDE YOUR [doomWAD] + [doomMOD#s]  
*Use FULL PATHs and AVOID SPACES for your [doomWAD] + [doomMOD#s]*  

	# EXAMPLE [DAZI-Template.sh] CONTENTS #  
	doomWAD=~/RetroPie/roms/ports/doom/doom2.wad  
	doomMOD1=~/RetroPie/roms/ports/doom/mods/brutalv21.pk3  
	doomMOD2=~/RetroPie/roms/ports/doom/mods/hellonearthstarterpack.wad  

HOW TO PRE-LOAD D00M M0Ds using the [Runcommand Launch Menu]:  
Select and Load a D00M-MOD using the [DAZI-Template.sh]  
PRESS [A] BUTTON TO CONFIGURE *(Before the ROM Loads)*  
*[EXIT WITHOUT LAUNCHING]*  
The Last D00M-M0D Selected will Still be Loaded in [/dev/shm/addon]  
Now Select any 0ther Desired D00M R0M and Launch with [lzdoom-dazi]  
Or Repeat the Process to Pre-Load more D00M-M0Ds  

HOW TO PRE-LOAD D00M M0Ds using the [dazi-mod-loader] MENU:  
[dazi-mod-loader] is Included for use with [lzdoom-addon]/[lzdoom-dazi]  
Use [dazi-mod-loader] from this Script directly, 0r Install it and...  
Configure it to Always Load when the [doom] P0RT Launches  

*DAZI can also configure the [srb2] and [srb2kart] AddOns CUSTOM Directory to D00M M0Ds*  
[srb2] AddOns DEFAULT  
/opt/retropie/configs/ports/srb2/addons  
/opt/retropie/configs/ports/srb2kart/addons  
/opt/retropie/configs/ports/srb2kart/DOWNLOAD  

[srb2] AddOns D00M M0Ds after DAZI  
~/RetroPie/roms/ports/doom/mods/srb2  
~/RetroPie/roms/ports/doom/mods/srb2kart  

[srb2] Configs  
/opt/retropie/configs/ports/srb2/config.cfg  
/opt/retropie/configs/ports/srb2kart/kartconfig.cfg  

**TIPs**  
[pk3/pk7] are Compressed Files Already, NO NEED to ZIP Individually  
[WADs] can be Compressed, but can take time to Extract if LARGE  
LARGE [WADs] might EXCEED the Size of [/dev/shm/] (tmpfs) on some HW  
 [ipk3] files typically do not Require you to Load a Main [iwad] but...  
You can RENAME [ipk3] -> [pk3] and load a [fakeiwad.wad] or [doom2.wad]  

[ZIPs] are good to use with Smaller M0Ds that have lots of files  
eg. The 0riginal [AliensTC] is Small and has numerous files to Load  
