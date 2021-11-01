# piHPSDR and FLDIGI setup on Raspberry Pi with Hermes-Lite 2

This guide documents steps to install and configure piHPSDR with digital mode applications on the Raspberry Pi

## Compile piHPSDR From Source Code
[piHPSDR Compile Instructions](https://github.com/n7ihq/piHPSDR/blob/main/piHPSDR%20Compile.pdf)  
Author: Christoph Wüllen, DL1YCF  

### PulseAudio Setup
**Omit Appendix D: creating loop-back "sound cards"**

**Install PulseAudio Volume Control**  
sudo apt install pavucontrol  

**Create PulseAudio configuration file**  
Create the file: ~/.config/pulse/default.pa  
Add:  
.include /etc/pulse/default.pa  
load-module module-null-sink sink_name=Virtual_Audio_Device sink_properties="device.description='Virtual Audio Device'"  
Save file  
Reboot computer  

### ALSA Setup
Before compiling piHPSDR  
Edit the file ~/pihpsdr/Makefile  
Uncomment the line #AUDIO_MODULE=ALSA
Save file

## Install and Compile Scripts for piHPSDR, LinHPSDR, Hamlib, FLDIGI, WSJT-X
Installs dependencies and compiles piHPSDR for PulseAudio operation  
The install script may be modified for ALSA operation  

[ReadMe](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/ReadMe.txt)  
[Install Script](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/install.sh)  
[Compile Script](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/compile.sh)  
Author: Christoph Wüllen, DL1YCF  
Install Script modified by: Jim Larsen, N7IHQ

## piHPSDR Menu
### Radio
Select Receivers: 1  
Select Filter Board: N2ADR  
Check HL2 PA Enable  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/piHPSDR%20Radio.png)  
### RX
Check Local Audio Output  
Select Built-in Audio Analog Stereo  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/piHPSDR%20RX.png)  
### TX
Check Local Microphone  
Select Monitor of Virtual Audio Device 
Check Tune use drive  
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
### Output Devices
Set levels to 100%  
[Screenshot]
### Input Devices
Set levels to 100%  
[Screenshot]
### Playback
piHPSDR: RX-0 on Built-in Audio Analog Stereo  
Set level for monitoring signals  
FLDIGI: playback on Virtual Audio Device  
Set level to 100%  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/PulseAudio%20Playback.png)  
### Recording
Select FLDIGI: capture from Monitor of Built-in Audio Analog Stereo  
Set level for waterfall display  
Select piHPSDR: TX from Monitor of Virtual Audio Device  
Set level to 50%  
[Screenshot](https://github.com/n7ihq/piHPSDR/blob/main/Screenshots/PulseAudio%20Recording.png)  

## piHPSDR Transmit Settings
FLDIGI: Click TUNE  
piHPSDR:  
Set Drive to 100  
Set Mic level for approximately 5 watts output  
