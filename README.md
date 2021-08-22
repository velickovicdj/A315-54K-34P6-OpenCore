# A315-54K-34P6 OpenCore macOS Big Sur

This repository contains prebuilt OpenCore files used for booting macOS Big Sur on Acer Aspire A315-54K-34P6.

<img src="screenshot.jpg">

## Hardware:

|                |                          	 |
|----------------|-------------------------------|
|**CPU**		 |`2.3GHz Intel Core i3-7020U`	 |
|**GPU**		 |`Intel HD 620`				 |
|**RAM**         |`8GB 2133MHz DDR4`             |
|**SSD**         |`256GB M.2 PCIe NVMe SSD`		 |
|**DISPLAY**     |`15,6" 1080p LCD Display`		 |
|**Wi-Fi/BT**    |`Qualcomm Atheros QCA9377`	 |
|**AUDIO** 		 |`Realtek ALC255`				 |

## Working:
- Graphics Acceleration.
- Keyboard & Trackpad with all macOS gestures.
- All ports (HDMI, USB 3.0, two USB 2.0, Ethernet, 3.5mm headphone jack).
- Wi-Fi (Replaced).
- Bluetooth (Some modifications required).
- AirDrop and Handoff.
- Audio (Speakers, headphones and internal microphone).
- iCloud and App Store.

Thanks to the [OpenIntelWireless](https://github.com/OpenIntelWireless) I managed to get Wi-Fi to work by replacing my `QCA9377` with `Intel AC 3160` and adding their Intel Wi-Fi driver in order for my adapter to be recognized in macOS. If your Intel wireless adapter is not in the [supported list](https://openintelwireless.github.io/itlwm/Compat.html#dvm-iwn) or if you have a different wireless adapter, you should remove `AirportItlwm.kext` from the Kexts folder. 

## Not tested:
- iMessage and FaceTime.

I didn't yet have a chance to test iMessages and FaceTime as I don't own an iPhone but will update in the future.

## Bluetooth fix:

So it's been months since I successfully booted into macOS Big Sur with this configuration and it wasn't till today that I found a solution for the Bluetooth issue. I thought it was faulty hardware as I never got the Bluetooth to be recognized in both macOS and Linux but to my surprising, it was something quite unexpected. Apparently, it seems like my Intel wireless adapter has some incompatible pins, or may I say a different arrangement from my old one (`QCA9377`). Long story short, I had to tape two pins on my `AC 3160`that are used to sense a WiFi/Bluetooth "power off" signal. Blocking the two pins prevents the adapter from receiving a "power off" signal and keeps it on continuously. Since the old adapter lacks these pins, taping the two in the new one seems to be a solution. If you are facing a similar issue or want to find out more, [**check out this amazing article that cleared it out to me**](https://thecomputerperson.wordpress.com/2016/11/04/how-to-mask-off-the-wifi-power-off-pins-on-m-2-ngff-wireless-cards-the-old-mini-pci-pin-20-trick/)

If your Intel Bluetooth device is not in the [supported list](https://openintelwireless.github.io/IntelBluetoothFirmware/Compat.html) or if you have a different Bluetooth device, you should remove `IntelBluetoothFirmware.kext` and `IntelBluetoothInjector.kext` from the Kexts folder. 

I went with an Intel for the Wi-Fi and Bluetooth as it was a cheaper solution (I got it for like 5 bucks used) and to be honest, I have no complaints whatsoever. The Wi-Fi and Bluetooth are working perfectly, I would say even better than what I had with `QCA9377` in Linux. For now, I'm just happy that I have 1 more USB port and that I don't have to use a USB Wi-Fi adapter anymore.

If you want a working Wi-Fi and Bluetooth out of the box, I suggest you look for Apple-branded Broadcom wireless counterparts.

One step closer to a perfect Hackbook!
 
## Credits:

[**Acer**](http://acer.com/) for the laptop.

[**Apple**](http://apple.com/) for the macOS.

[**RehabMan**](https://github.com/RehabMan) for the great guides.

[**alexandred**](https://github.com/alexandred) for VoodooI2C kext and making it work with the trackpad.

[**Acidanthera**](https://github.com/acidanthera) for awesome kexts and first-class support for hackintosh enthusiasts.

[**OpenIntelWireless**](https://github.com/OpenIntelWireless) for Intel WI-FI ant Bluetooth drivers.