# A315-54K-34P6 OpenCore macOS Big Sur

This repository contains prebuilt OpenCore EFI files used for booting macOS Big Sur on Acer Aspire A315-54K-34P6.


## Hardware:

|                |                          	 |
|----------------|-------------------------------|
|**CPU**		 |`2.3GHz Intel Core i3-7020U`	 |
|**GPU**		 |`Intel HD 620`				 |
|**RAM**         |`8GB 2133MHz DDR4`             |
|**SSD**         |`256GB M.2 PCIe NVMe SSD`		 |
|**DISPLAY**     |`15,6" 1080p LCD Display`		 |
|**WI-FI/BT**    |`Qualcomm Atheros QCA9377`	 |
|**AUDIO** 		 |`Realtek ALC255`				 |

## Working:
- Graphics Acceleration.
- Keyboard & Trackpad with all macOS gestures.
- WI-FI (Replaced).
- Audio (Speakers, headphones and internal microphone).
- iCloud and App Store.

Thanks to the [OpenIntelWireless](https://github.com/OpenIntelWireless) I managed to get WI-FI to work by replacing `QCA9377` with `Intel AC 3160` and adding their  `AirportItlwm` kernel extension in order for WI-FI adapter to be recognized. If your Intel wireless adapter is not in the [supported list](https://openintelwireless.github.io/itlwm/Compat.html#dvm-iwn) or if you have a different wireless adapter, you should remove `AirportItlwm.kext` from the Kexts folder. 

If you want native WI-FI/Bluetooth experience in macOS, you should look for Apple branded Broadcom wireless counterparts.

## Not tested:
- Bluetooth.
- Airdrop and Handoff.
- iMessages and FaceTime.

 
## Credits:

[**Acer**](http://acer.com/)  for the laptop.

[**Apple**](http://apple.com/)  for the macOS.

[**RehabMan**](https://github.com/RehabMan)  for the great guides.

[**alex.daoud**](https://github.com/alexandred)  for VoodooI2C kext and making it work with the trackpad.

[**acidanthera**](https://github.com/acidanthera)  for awesome kexts and first-class support for hackintosh enthusiasts.