# piHPSDR Setup for Raspberry Pi

## Compile Instructions for piHPSDR
[piHPSDR Compile Instructions](https://16866925358202169909.googlegroups.com/attach/1e89c10f8df55/Linux-CompileFromSources.pdf?part=0.1&view=1&view=1&vt=ANaJVrHZ1LZ2fEuy3iSNndb5Q19r6DNVudqEvoqXk-__CruZ34FcbCEbTum7GwsoKW3Ztqo1dllqumkUCpb7PTCzxfnZcqGnn0ZwXp2dJT5GWt1ny0ZjqLM)  
Author: Christoph Wüllen, DL1YCF

## Compile Scripts for piHPSDR, LinHPSDR, Hamlib, FLDIGI, WSJT-X
[piHPSDR Compile Scripts](https://groups.google.com/g/hermes-lite/c/4Bnf2p0C1S4/m/AlGdB8tiAwAJ)  
Author: Christoph Wüllen, DL1YCF

## PulseAudio Setup
**Install PulseAudio Volume Control**  
sudo apt install pavucontrol  

**Create PulseAudio configuration file**  
nano .config/pulse/default.pa  
.include /etc/pulse/default.pa  
load-module module-null-sink sink_name=Virtual_Audio_Device sink_properties="device.description='Virtual Audio Device'"

Reload PulseAudio: pulseaudio -k
