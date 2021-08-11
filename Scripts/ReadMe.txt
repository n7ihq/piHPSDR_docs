=================================================================
Compile SDR and digimode programs on RaspberryPi from the sources
=================================================================

C. van Wullen, DL1YCF.


These are detailed instructions how to compile the programs

piHPSDR
linHPSDR
Fldigi
WSJT-X

on a Raspberry-Pi directly from the sources. This has been tested
on my RaspberryPi Model 4.

First, the RaspberryPi operating system has been downloaded from

https://www.raspberrypi.org/software/

Go to "manuall install software" and select the option
"Raspberry Pi OS with desktop". The file I downloaded
was named

2020-08-20-raspios-buster-armhf.img

and contains the kernel version 5.4. This image file must
be "burned" onto a micro-SD card, which is then inserted
into the Raspberry Pi. Upon first-time boot, you have to
choose your password and make local settings (keyboard
layout, time zone, etc.).

The following steps need a working internet connection.
If your RaspPi is connected to a router offering DHCP
service, this works. Probably it also works if connected
via WiFi but this I have not tested.


STEP A
======

To prepeare the installation, we first update the operating
system and load a helper program that we might need in a minute.
To this end, open an terminal window and type in the commands

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install dos2unix

The first two commands update the operating system, and the
third one loads the "dos2unix" command that we might need
in the next step.

STEP B
======

Now it is a good time to re-boot your RaspPi. This is necessary
if the kernel has been upgraded in step A. To do so, simply
type

sudo reboot

in a terminal window or select "Reboot" from the "Shutdown" menu.

STEP C
======

Copy the two files "compile.sh" and "install.sh" into the
home directory of the RaspberryPi user (which has the name "pi").
There are several options to do so. For example, you can start
a web browser and download the files, are even download them
to some other computer and transfer them via a USB stick.
If you want to transfer them from some other computer using
"scp" then you have to enable "SSH" in the RasperryPi
configuration menu (in the sub-menu "Interfaces").

Now type in the following commands to make compile.sh and install.sh
"usable":

dos2unix compile.sh
chmod 755 compile.sh
dos2unix install.sh
chmod 755 install.sh

In many cases, these commands are not necessary but can also do
no harm. The "dos2unix" commands convert from DOS/Windows 
end-of-line convention to Linux end-of-line convention. This
might be necessary if you download the files on a Windows computer
and then transfer to the RaspPi. The "chmod" commands set
execute permission on these files.

STEP D
======

To download all the necessary source code trees from the internet,
simply open a terminal window and type in

./install.sh

This not only downloads the required RaspPi-OS software packages
and all the source code, but also creates desktop icons,
start script, and gives you a fixed IP address and loopback sound devices
(for using the digimode programs with piHPSDR or linHPSDR), as well as some
GPIO-related stuff. It also enables MIDI, LOCALCW and STEMLAB support in
piHPSDR.

This step takes about 10 min, but this strongly depends on your internet speed.

Note that this step is meant to be performed *once* on a "virgin" system. It deletes
the directories such as pihpsdr and all local settings contained therein.


STEP E
======

To compile all parts, simply use the command

./compile.sh

This steps takes quite some time (34 min in my case), mainly because I compile fldigi
using a single CPU only. The reason is, that there is one source code module in fldigi
that needs a large fraction of the available memory so compiling several modules 
concurrently on several CPUs may lead to memory shortage.

That's it. Double-clicking the icons should start the programs. It is annoying that
you are asked each time whether you want to start in the command in a terminal window
or not. This can be suppressed using the file manager: open the file manager, go to the
Desktop, select the desktop shortcut, then select Edit->Preferences and check the
box with the text "Don't ask options on launch executable files".

I have tested this several times, and incorporated the findings of my "guinea pigs".
For example, the dos2unix stuff never occured to me since my Desktop computer is a
Macintosh.

