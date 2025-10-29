# D00M Addon ZIP Integration (DAZI)  
![lzdoom-dazi.png](https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.png)  

Integration of D00M-M0D ZIP/7z files into RetroPie.  
Includes D00M M0D Loader Menu that can be Launched from anywhere or Installed.  
Additionally make use of the *Runcommand Launch Menu* to Pre-Load D00M M0Ds.  
**Press [A] to Configure** -> **EXIT WITHOUT LAUNCHING** to Pre-Load One *or MORE* D00M M0Ds.  
Additionally Manage [srb2] and [srb2kart] AddOns along with D00M M0Ds.  

**Before you get started:**  
A D00M P0RT such as **uzdoom**/**gzdoom**/**lzdoom**/**lr-prboom**/**prboom-plus** should be **INSTALLED**  
Place your **[M0D].ZIP/PK3/PK7** Files in: **~/RetroPie/roms/ports/doom/mods/***  

**HOW DOES IT WORK?**  
DAZI will Extract [ZIPs] [7z] Files and Load [M0Ds] into Doom [AddOnDIRs]  
- UZDoom/GZDoom/LZDoom:  
[$zdoom-addon] Loads M0Ds from ADDON [..roms/ports/doom/addon/]  
[$zdoom-dazi]  Loads M0Ds from TMPFS [/dev/shm/addon/]  
[$zdoom-dazi+] Loads M0Ds from BOTH  [TMPFS+ADDON] in that 0rder  
[$zdoom-dazi+warp] Loads from [TMPFS+ADDON] and Includes [-WARP -SKILL]  

- PRBOOM-PLUS:  
[prboom-plus] Loads M0Ds from [..configs/prboom-plus/autoload/doom-all]  
[prboom-plus+warp] Loads from [../doom-all] and Includes [-WARP -SKILL]  

- LR-PRBOOM:  
[lr-prboom] Loads M0Ds based on the Config File [DOOMWADDIR/prboom.cfg]  
DAZI can AutoGenerate a [prboom.cfg] based on [addonDIR] when Installed  

## INSTALLATION  
If you want 1-Run-N-Done:  
```bash
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.sh -P /dev/shm/; sudo chmod 755 /dev/shm/lzdoom-dazi.sh; mv /dev/shm/lzdoom-dazi.sh /dev/shm/lzdoom-dazi-tmp.sh; /dev/shm/lzdoom-dazi-tmp.sh
```

If you want to Put the Install Script in the retropiemenu [+Icon]:  
```bash
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.sh -P ~/RetroPie/retropiemenu
wget https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.png -P ~/RetroPie/retropiemenu/icons
```

0ptionally you can Add an Entry [+Icon] to your retropiemenu [gamelist.xml]:  
*Example Entry:*  
```
	<game>
		<path>./lzdoom-dazi.sh</path>
		<name>[lzdoom] DAZI</name>
		<desc>Configure [lzdoom-dazi] for [RetroPie].</desc>
		<image>/home/pi/RetroPie/retropiemenu/icons/lzdoom-dazi.png</image>
	</game>
```

If you want to GIT it All:  
```bash
cd ~
git clone --depth 1 https://github.com/RapidEdwin08/dazi.git
chmod 755 ~/dazi/lzdoom-dazi.sh
cd ~/dazi && ./lzdoom-dazi.sh

```

## REFERENCES   

**TIPs:**  
AVOID using [S P A C E S] and [$PEC!AL CH@RACT€R$] in your M0D NAMEs  

Some M0Ds already come as [ZIP] since ZDoom supports Loading [ZIP] but  
You can RENAME [ZIP] -> [pk3] if you want to Ignore Extraction by DAZI  
eg.  [strayDoom.v01.zip]  ->  [strayDoom_v01.pk3]  

[ipk3] files typically do not Require you to Load a Main [iwad] but  
You can RENAME [ipk3] -> [pk3] and load a [fakeiwad.wad] or [doom2.wad]  

[pk3/pk7] are Compressed Files Already, NO NEED to ZIP Individually  
[WADs] can be Compressed, but can take time to Extract if LARGE  
LARGE [WADs] might EXCEED the Size of [/dev/shm/] (tmpfs) on some HW  

[deh] and [bex] DEHACKED Files are Conditionally Supported with DAZI  
[bex] Files are Dehacked Files Supported by B00M Compatible P0RTs Only  
[deh] Files in lzdoom must be Specified in the Loading 0rder using -deh  

A [deh] File Added to a WAD can be Loaded in lzdoom Normally with -file  
A [deh] File Added to a WAD is also supported by BOTH lzdoom/lr-prboom  

eg. Create a NEW WAD with SLADE -> Import the [Custom.deh] File ALONE  
RENAME the Imported [deh] "DEHACKED" -> Save file [Custom_deh.wad]  
The DAZI Generate prboom.cfg Feature Follows [deh.wad] Naming Scheme  

[ZIPs] are good to use with Individual MAPs/MEGAWADs to Save Space  
ADD Numeric 0rder to the NAME(s) before Compressing MAPs/MEGAWADs  
eg. [aaliens.wad] 135MB -> (01_aaliens.wad) -> [aaliens.zip] 37MB  

[ZIPs] are good to use with Smaller M0Ds that have lots of files  
eg. The 0riginal [AliensTC] is Small and has numerous files to Load  

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

**HOW TO PRE-LOAD D00M M0Ds** using the *[Runcommand Launch Menu]*:  
Select and Load a D00M-MOD using the [DAZI-Template.sh]  
PRESS [A] BUTTON TO CONFIGURE *(Before the ROM Loads)*  
*[EXIT WITHOUT LAUNCHING]*  
The Last D00M-M0D Selected will Still be Loaded in [/dev/shm/addon]  
Now Select any 0ther Desired D00M R0M and Launch with [lzdoom-dazi]  
Or Repeat the Process to Pre-Load more D00M-M0Ds  

**HOW TO PRE-LOAD D00M M0Ds** using the *[dazi-mod-loader]* MENU:  
[dazi-mod-loader] is Included for use with [lzdoom-addon]/[lzdoom-dazi]  
Use [dazi-mod-loader] from this Script directly, 0r Install it and...  
Configure it to Always Load when the [doom] P0RT Launches  

**HOW LEVEL WARP WITH DAZI:**  
*Use the M0D Loader Menu to *SELECT* [Episode] [Map] [Difficulty] Settings:*  
DAZI will Stream-Edit [emulators.cfg] to *APPLY* [-warp -skill ] Settings  
Select appropriate WARP Emulator [lzdoom-dazi+warp] or [prboom-plus+warp]  

Warp+Difficulty Examples [-warp E# M# -skill S#]:  
[-warp 5 9 -skill 4] Ultimate Doom SIGIL E5M9 on Ultra-Violence  
[-warp 6 1 -skill 1] Heretic FatesPath E6M1 on Thou Needeth a Wet-Nurse  
[-warp 2 1 -skill 3] Ultimate Doom AliensTC E2M1 on Hurt me plenty  
[-warp  31 -skill 5] Doom II SecretWolfensteinLevel MAP31 on Nightmare!  
NOTE: Leave [Episode] set to [NONE] for D00M II Maps  

**prboom.cfg Files**  
[prboom.cfg] Files are Required for Loading M0Ds with [lr-prboom]  
DAZI can Generate [prboom.cfg] Files based on [addonDIR] Contents  
[prboom.cfg] Files Loaded by DAZI get Cached in [addonDIR/.0ther]  

*@runcommand-onlaunch:*  
DAZI will MOVE [addonDIR/.0ther/prboom.cfg] to [doomWADdir/doomWADname]  
DAZI will COPY [prbmsav?.dsg] Gamesaves to [doomWADdir/doomWADname]  
DAZI will MAKE [prboom.cfg] File if Not Found [doomWADdir/doomWADname]  

*@runcommand-onend:*  
DAZI will MOVE the Last Running [prboom.cfg] -> [prboom.cfg.last]  
DAZI will MOVE back any [prbmsav?.dsg] Gamesaves to DEFAULT Location  

**[srb2] and [srb2kart] AddOns:**  
*DAZI can configure the [srb2] and [srb2kart] AddOns CUSTOM Directory to D00M M0Ds*  
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

***SOURCES:***  
[https://github.com/drfrag666/gzdoom](https://github.com/drfrag666/gzdoom/releases/tag/3.87c)  
[https://romero.com/shop/p/onehumanity](https://romero.com/shop/p/onehumanity)  
[https://romero.com/sigil](https://romero.com/sigil)  
