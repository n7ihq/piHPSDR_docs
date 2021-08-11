# piHPSDR Setup: Raspberry Pi with Hermes-Lite 2

## Manual Compile Instructions for piHPSDR
[piHPSDR Compile Instructions](https://github.com/n7ihq/piHPSDR/blob/main/piHPSDR%20Compile.pdf)  
Author: Christoph Wüllen, DL1YCF

## Compile Scripts for piHPSDR, LinHPSDR, Hamlib, FLDIGI, WSJT-X
[ReadMe](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/ReadMe.txt)  
[Install Script](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/install.sh)  
[Compile Script](https://github.com/n7ihq/piHPSDR/blob/main/Scripts/compile.sh)  
Author: Christoph Wüllen, DL1YCF

## PulseAudio Setup
**Install PulseAudio Volume Control**  
sudo apt install pavucontrol  

**Create PulseAudio configuration file**  
Included in piHPSDR Install Script  
nano .config/pulse/default.pa  
.include /etc/pulse/default.pa  
load-module module-null-sink sink_name=Virtual_Audio_Device sink_properties="device.description='Virtual Audio Device'"

Reload PulseAudio: pulseaudio -k
