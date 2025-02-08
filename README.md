# A315-54K-34P6 OpenCore Hackintosh

[![Status](https://img.shields.io/badge/Status-Maintained-blue.svg)](https://github.com/velickovicdj/A315-54K-34P6-OpenCore)
[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.3-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![macOS](https://img.shields.io/badge/macOS-13.7.3-brightgreen.svg)](https://www.apple.com/macos/ventura)

:warning: **WARNING:**
This OpenCore configuration is optimized for my specific hardware, so please read carefully before doing anything or use it only as a reference. I suggest you to refer to [Dortania](https://dortania.github.io/getting-started) for anything else. 

<p align="center">
  <img src="/img/sysinfo.png" alt="System Information">
</p>

## Hardware

|**Category**|**Component**                 	   |**Note**			 				      	   |
|------------|-------------------------------------|-----------------------------------------------|
|**CPU**	 |2.3GHz Intel Core i3-7020U	 	   |										       |
|**iGPU**	 |Intel HD Graphics 620				   |										       |
|**RAM**     |12GB (4GB non-removable) 2133MHz DDR4|Replaced the original 4GB with a new 8GB stick.|
|**SSD**     |256GB M.2 PCIe NVMe SSD		 	   |										       |
|**Display** |15,6" 1080p LCD non-touch display	   |No ambient light sensor.					   |
|**Wi-Fi/BT**|Intel Dual Band Wireless-AC 3160	   |Replaced original Qualcomm QCA9377.	      	   |
|**Ethernet**|Realtek RTL8111				 	   |										       |
|**Audio** 	 |Realtek ALC255				 	   |69 for the layout ID seems to work the best.   |
|**Input**   |PS2 Keyboard & I2C Synaptics TrackPad|										       |

## Working/not working

- [x] CPU power management.
- [x] Hardware acceleration.
- [x] Sleep/Wake.
- [x] Battery read-out.
- [x] Audio (Internal speakers, Internal microphone, 3.5mm headphone jack).
- [x] Keyboard & trackpad with all macOS gestures.
- [x] Wi-Fi & Bluetooth.
- [x] USB ports.
- [x] HDMI video & audio output.
- [x] Ethernet.
- [x] VGA WebCam.
- [ ] AirDrop.
	- Detection and receiving only seem to work.
- [x] Handoff.
- [x] iServices (iCloud, App Store, iMessage, FaceTime).

## BIOS

Currently, I'm running on the latest BIOS release for this laptop - [InsydeH20 v1.11 (30.09.2020)](https://www.acer.com/ac/en/IL/content/support-product/8028?b=1), and for the sake of convenience, I unlocked the advanced menu so I could more easily tweak some options for better compatibility with the macOS. If some of these options are not present in your BIOS, don't worry because most are not crucial but do try to match as closely as possible.

|**Option**   				  |**Value**|**Note**			 				      	  																									  																		   	  |
|-----------------------------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|**Boot Mode**	 			  |UEFI	    |***Crucial*** 																									  																			  								  |
|**SATA Mode**	 			  |AHCI	    |***Crucial***																									  																			  								  |
|**Secure Boot** 			  |Disabled |***Crucial*** 																									  																			  								  |
|**Fast Boot**   			  |Enabled  |I'd recommend disabling it when debugging.	  																									  																			  |
|**Intel VT-d**  			  |Disabled |Can be enabled if you set `DisableIoMapper` to `true` under Kernel -> Quirks in config.plist.					  								  																			  |
|**CFG Lock (MSR_E2)**    	  |Disabled |If you cannot find this option then set `AppleXcpmCfgLock` to `true` under Kernel -> Quirks in config.plist. Your system will not boot otherwise.																			  |
|**DVMT Pre-Allocated Memory**|64MB	    |Setting it to anything above is unnecessary for MacBookPro14,1 SMBIOS. If you cannot find this option and/or you are not sure if you pre-allocated memory is >= 64MB then you should patch your VRAM (see the details below).|

### How to unlock advanced menu in InsydeH20 BIOS on Acer Aspire 3 series

- Launch BIOS by tapping the F2 key repeatedly right after booting.
- When in BIOS, hold down the Power button to force a shutdown.
- While the laptop is off, press (in order) the following keys: `F4`, `4`, `R`, `F`, `V`, `F5`, `5`, `T`, `G`, `B`, `F6`, `6`, `Y`, `H`, `N`.
- Launch BIOS again and you should now see all the menus that were hidden before.

There are also other methods for modifying UEFI variables such as the shell method, but I would advise you against them because if done wrong you could brick your laptop.

### VRAM patching

If your DVMT pre-allocated memory is <= 32MB AND you use my config.plist without necessary tweaking, you will run into issues. 

To patch VRAM, add the following under DeviceProperties -> PciRoot(0x0)/Pci(0x2,0x0) in config.plist:

|**Key**					 |**Type**|**Value**|
|----------------------------|------- |---------|
|**framebuffer-patch-enable**|Data	  |01000000	|
|**framebuffer-fbmem**	     |Data	  |00003001	|
|**framebuffer-stolenmem**   |Data    |00009000	|

## SSDTs

I will only describe the SSDTs that are not essential for functioning but are present in my EFI.

|**SSDT**          |**Description**                 			 																																			   |
|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|**SSDT-PLUG**	   |***Crucial*** 		 																																	   								   |
|**SSDT-PNLF**	   |Fixes backlight.				 																																						   |
|**SSDT-TPAD**     |My approach for fixing I2C trackpad. 																																					   |
|**SSDT-ALS0**     |Provides macOS with a fake Ambient Light Sensor device (ALS), so it could store the current brightness level and keep it after reboots.		 		 									   |
|**SSDT-DMAC**     |Provides macOS with a fake Direct Memory Access Controller (DMAC), because the device is present in any Intel-based Mac. The necessity for this SSDT is unknown, consider it as "cosmetic".|
|**SSDT-EC-USBX**  |***Crucial***	 																																			   							   |
|**SSDT-SBUS-MCHC**|Fixes AppleSMBus support in macOS.				 		 																																   |
|**SSDT-MEM2** 	   |Makes the iGPU use MEM2 instead of TMPX, so the IOAccelMemoryInfoUserClient is loaded correctly.			 		 																	   |
|**SSDT-GPRW**     |Fixes instant wake on USB/power state change.																																			   |

I merged the SSDTs mentioned above into one (SSDT-A315-54K) for a minimal EFI. If that's not something you like, I've included SSDT/src folder where you can find the individual ones.
 
## Kexts

I will only describe the kexts that are worth describing. The order shown below is also the order of loading.

|**Kext**         								   |**Description**                 			 																										 									   									|
|--------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|**Lilu**	   									   |***Crucial***	 																						 									   																				|
|**VirtualSMC**	   								   |***Crucial***			 																					 									   																			|
|**SMCBatteryManager**     						   | 																																			 									   											|
|**SMCLightSensor**     						   |Supplement to fake ambient light sensor device mentioned in ACPI.		 		 										   																					 				|
|**SMCProcessor**     							   |Allows preciser measurement of the CPU.		 		 										   																					 									   		|
|**WhateverGreen**     							   |***Crucial***																									 									   																		|
|**AppleALC**  									   |**I Compiled it specifically for my ALC255 codec**. If your codec is different, replace this kext. 																				   											|
|**VoodooPS2Controller + VoodooPS2Keyboard plugin**|				 		 																													 									   											|
|**VoodooI2C + plugins**   						   |			 		 																	   													 									   											|
|**VoodooI2CHID**     		   					   |																																			 									   											|
|**AirportItlwm**     	   						   |**I compiled it specifically for my AC 3160 Wi-Fi firmware**. If your **Intel** wireless card is not AC 3160, replace this kext and make sure the version matches your macOS version.										|
|**IntelBTPatcher**						   | |
|**BlueToolFixup**						   | |
|**IntelBluetoothFirmware**						   |**I compiled it specifically for my AC 3160 Bluetooth firmware**. If your **Intel** wireless card is not AC 3160, replace this kext.		 									   	   										|
|**RealtekRTL8111**        						   |																																			 									   											|
|**NVMeFix**     		   						   |Optimizes power and energy consumption on non-Apple SSDs.																																			 						|
|**USBPorts**     		   						   |**I mapped USB ports specifically for this laptop model**. If your model is different, you should remove this kext and do your [USB mapping](https://dortania.github.io/OpenCore-Post-Install/usb/intel-mapping/intel.html).|

## SMBIOS

PlatformInfo section of the config.plist is left empty for security reasons. You need to generate your own SMBIOS data and change the corresponding values (`MLB`, `ROM`, `SystemSerialNumber`, `SystemUUID`) under PlatformInfo in config.plist. Luckily, [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS) can take care of that for you.

## Miscellaneous

<details>
<summary><h3>Wi-Fi/Bluetooth</h3></summary>
<br>

I managed to get the Wi-Fi working by replacing my original Qualcomm QCA9377 with Intel AC 3160 and with now various Intel wireless cards being supported in macOS (thanks to the [OpenIntelWireless](https://github.com/OpenIntelWireless)), I've been able to get mine up and running as well. If your Intel wireless card is not in the [supported list](https://openintelwireless.github.io/itlwm/Compat.html#dvm-iwn) or if you have a different wireless card, you should remove AirportItlwm.kext from the Kexts folder.

As for the Bluetooth, it was a bit more complicated. It's been months since I successfully booted into macOS with this configuration, and it wasn't till recently that I worked out a solution for Bluetooth. I thought it was faulty hardware as I never got the Bluetooth to work in both macOS and Linux, but to my surprise, it was something quite not expected.

### AC 3160 Bluetooth hardware-level fix

Apparently, it seems like my Intel wireless card has some incompatible pins, or may I say a different arrangement from the original one (QCA9377). Long story short, I had to tape two pins on my AC 3160 that are used to sense a Wi-Fi/Bluetooth "power off" signal. Blocking the two pins prevents the card from receiving a "power off" signal and keeps it on continuously.

<img align="right" src="img/m2pinmask.jpg">

Since the old card (QCA9377) lacked these pins, taping the two in the new one seems to be a solution. If you are facing a similar issue or want to find out more, check out this amazing [article](https://thecomputerperson.wordpress.com/2016/11/04/how-to-mask-off-the-wifi-power-off-pins-on-m-2-ngff-wireless-cards-the-old-mini-pci-pin-20-trick) that cleared it out to me.

If your Intel Bluetooth device is not in the [supported list](https://openintelwireless.github.io/IntelBluetoothFirmware/Compat.html) or if you have a different Bluetooth device, you should remove IntelBluetoothInjector and IntelBluetoothFirmware.kext from the Kexts folder.

##

I went with an Intel for the Wi-Fi & Bluetooth as it was a cheaper solution (I got it for like $5 used) and to be honest, I have no complaints whatsoever. The Wi-Fi & Bluetooth are working perfectly, I would say even better than what I had with QCA9377 in Linux. For now, I'm just happy that I have 1 more USB port and that I don't have to use a USB Wi-Fi adapter anymore.

If you want a working Wi-Fi & Bluetooth out of the box, I suggest you look for Apple-branded Broadcom wireless counterparts.

</details>

<details>
<summary><h3>DeviceProperties</h3></summary>
<br>

Other than `PciRoot(0x0)/Pci(0x1F,0x3)` and `PciRoot(0x0)/Pci(0x2,0x0)`, all other entries under DeviceProperties -> Add are purely cosmetic and you can safely remove them if you wish so.

</details>

<details>
<summary><h3>OpenCore beauty treatment</h3></summary>
<br>

This EFI is aesthetically configured to include OpenCore's GUI and boot-chime. You can disable boot-chime by setting `PlayChime` to `Disabled` under UEFI -> Audio in config.plist.
I also applied my custom theme for OpenCanopy (see it here: [EnterTwilight](https://github.com/velickovicdj/OpenCanopy-EnterTwilight)). You can change the desired theme at any time by changing the `PickerVariant` value in config.plist with respect to the path of the theme in the OC/Resources/Image folder (E.g. `PickerVariant` value `Acidanthera/GoldenGate` corresponds to the path OC/Resources/Image/Acidanthera/GoldenGate).

I prefer skipping the boot picker and going straight to macOS, but if you wish to have it on every boot set `ShowPicker` to `true` under Misc -> Boot in config.plist.

**TIP 1:** You can slightly speed up the boot time by setting `ConnectDrivers` to `false` under UEFI in config.plist, but you'll have to give up on the fancy boot-chime.

**TIP 2:** Even if `ShowPicker` is set to `false`, you can still access the OpenCore boot picker by holding the escape key when booting, just make sure that `PollAppleHotKeys` is set to `true`.

</details>

## Credits

[**Acer**](http://acer.com) for the laptop.

[**Apple**](http://apple.com) for the macOS.

[**RehabMan**](https://github.com/RehabMan) for the great guides.

[**Acidanthera**](https://github.com/acidanthera) for awesome kexts and first-class support for hackintosh enthusiasts.

[**Alexandre Daoud**](https://github.com/alexandred) for VoodooI2C kext and making it work with the trackpad.

[**OpenIntelWireless**](https://github.com/OpenIntelWireless) for Intel WI-FI & Bluetooth drivers.