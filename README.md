# piHPSDR Setup: Raspberry Pi with Hermes-Lite 2

## Manual Compile Instructions for piHPSDR
[piHPSDR Compile Instructions](https://github.com/n7ihq/piHPSDR/blob/main/piHPSDR%20Compile.pdf)  
Omit ALSA setup
Author: Christoph Wüllen, DL1YCF

## Compile Scripts for piHPSDR, LinHPSDR, Hamlib, FLDIGI, WSJT-X
[ReadMe](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/ReadMe.txt)  
[Install Script](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/install.sh)  
[Compile Script](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/compile.sh)  
Author: Christoph Wüllen, DL1YCF  
Install Script revised by Jim Larsen, N7IHQ

## PulseAudio Setup
**Install PulseAudio Volume Control**  
sudo apt install pavucontrol  

**Create PulseAudio configuration file**  
Included with piHPSDR Compile Script  
nano ~/.config/pulse/default.pa  
Add:  
.include /etc/pulse/default.pa  
load-module module-null-sink sink_name=Virtual_Audio_Device sink_properties="device.description='Virtual Audio Device'"  
Reload PulseAudio: pulseaudio -k

## piHPSDR Menu
### Radio
Select Receivers: 1  
Select Filter Board: N2ADR  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/piHPSDR%20Radio.png)  
### RX
Check Local Audio Output  
Select Built-in Audio Analog Stereo
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/piHPSDR%20RX.png)  
### TX
Check Local Microphone  
Select Monitor of Virtual Audio Device
Set Tune Percent: 100 
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/piHPSDR%20TX.png)  
### PA
Calibrate: Set all bands to 39.0
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/piHPSDR%20PA.png)  
### RIGCTL
Check Rigctl Enable  
Set RigCtl Port Number: 19090  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/piHPSDR%20RIGCTL.png)  

## FLDIGI Configuration
### Soundcard > Devices
Check PulseAudio  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/FLDIGI%20Sound.png)  
### Rig Control > Hamlib
Select Rig: OpenHPSDR PiHPSDR  
Set Device: localhost:19090  
Check Use Hamlib  
Click Initialize  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/FLDIGI%20Hamlib.png)  

## PulseAudio Volume Control
### Playback
Select piHPSDR: RX-0 on Built-in Audio Analog Stereo  
Set audio level for listening to signals  
Select FLDIGI: playback on Virtual Audio Device  
Set audio level for clean transmit signal  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/PulseAudio%20Playback.png)  
### Recording
Select FLDIGI: capture from Monitor of Built-in Audio Analog Stereo  
Select piHPSDR: TX from Monitor of Virtual Audio Device  
Set audio level to ?  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/PulseAudio%20Recording.png)  
