#!/bin/sh
##########################################################
#
# Part 0: Upgrade operating system.
# ------- This is normally done automatically when
#         booting for the first time from a "fresh"
#         operating system image. Do do this manually,
#         run the following two commands in a terminal
#         window
#
#         sudo apt-get update
#         sudo apt-get upgrade
#
#         and reboot the system.
#
##########################################################
#
# PART 1: update installed software and load required
# ------- packages
#
##########################################################
#
# ------------------------------------
# Install standard tools and compilers
# ------------------------------------
#
sudo apt-get --yes install vim
sudo apt-get --yes install make
sudo apt-get --yes install gcc
sudo apt-get --yes install gfortran
sudo apt-get --yes install git
sudo apt-get --yes install pkg-config
sudo apt-get --yes install cmake
sudo apt-get --yes install autoconf
sudo apt-get --yes install automake
sudo apt-get --yes install libtool
#
# ---------------------------------------
# Install libraries necessary for piHPSDR
# ---------------------------------------
#
sudo apt-get --yes install libfftw3-dev
sudo apt-get --yes install libgtk-3-dev
sudo apt-get --yes install libasound2-dev
sudo apt-get --yes install libcurl4-openssl-dev
sudo apt-get --yes install libusb-1.0-0-dev
sudo apt-get --yes install libi2c-dev
sudo apt-get --yes install libcrypt1
#sudo apt-get --yes install wiringpi

#
# Do not obtain "wiringpi" from the Raspian archive,
# since this version is not the latest one and may
# not fully support the Pi-4. Instead, install from
# the original location. Note this is a 32-bit version,
# so on 64-bit systems use wiringpi from your distribution.
#
cd /tmp
wget https://project-downloads.drogon.net/wiringpi-latest.deb
sudo dpkg -i wiringpi-latest.deb

#
# ----------------------------------------------
# Install standard libraries necessary for SOAPY
# ----------------------------------------------
#
sudo apt-get install --yes libad9361-dev
sudo apt-get install --yes bison
sudo apt-get install --yes flex
sudo apt-get install --yes libxml2-dev
#
# -----------------------------------------------
# Install standard libraries necessary for FLDIGI
# -----------------------------------------------
#
sudo apt-get install --yes libfltk1.3-dev
sudo apt-get install --yes portaudio19-dev
sudo apt-get install --yes libsamplerate0-dev
sudo apt-get install --yes libsndfile1-dev
#
# ----------------------------------------------
# Install standard libraries necessary for WSJTX
# ----------------------------------------------
#
sudo apt-get install --yes libboost-dev
sudo apt-get install --yes libboost-log-dev
sudo apt-get install --yes libboost-regex-dev
sudo apt-get install --yes qt5-default
sudo apt-get install --yes qttools5-dev
sudo apt-get install --yes qttools5-dev-tools
sudo apt-get install --yes qtmultimedia5-dev
sudo apt-get install --yes libqt5multimedia5-plugins
sudo apt-get install --yes libqt5serialport5-dev
sudo apt-get install --yes libudev-dev
#
##########################################################
#
# PART 2: download sources (do not yet compile them)
# ------- this REMOVES any existing directories, including
#         the local settings stored therein!
#
##########################################################
#
# --------------------
# Dowload WDSP library
# --------------------
#
cd $HOME
rm -rf wdsp
git clone https://github.com/dl1ycf/wdsp
#
# ----------------------
# Download SoapySDR core
# ----------------------
#
cd $HOME
rm -rf SoapySDR
git clone https://github.com/pothosware/SoapySDR.git
#
# ----------------------------------------
# Download libiio (needed for Soapy Pluto)
# ----------------------------------------
#
cd $HOME
rm -rf libiio
git clone https://github.com/analogdevicesinc/libiio.git
#
# ----------------------------------
# Download the SoapySDR Pluto module
# ----------------------------------
#
cd $HOME
rm -rf SoapyPlutoSDR
git clone https://github.com/pothosware/SoapyPlutoSDR
#
# ------------------------------------
# Download piHPSDR and adjust Makefile
# ------------------------------------
#
cd $HOME
rm -rf pihpsdr
git clone https://github.com/dl1ycf/pihpsdr
#
# Copy pihpsdr Makefile to GNUmakefile and make adjustments:
#  - in some distributions, wiringpi needs libcrypt
#  - furthermore, activate LOCALCW, MIDI, STEMLAB-without-AVAHI
#
cd pihpsdr
cp Makefile GNUmakefile
sed -e "s/#MIDI_INCLUDE/MIDI_INCLUDE/" GNUmakefile > tmp.make
mv tmp.make GNUmakefile
sed -e "s/#LOCALCW_INCLUDE/LOCALCW_INCLUDE/" GNUmakefile > tmp.make
mv tmp.make GNUmakefile
sed -e "s/#STEMLAB_DISCOVERY=STEMLAB_DISCOVERY_NOAVAHI/STEMLAB_DISCOVERY=STEMLAB_DISCOVERY_NOAVAHI/" GNUmakefile > tmp.make
mv tmp.make GNUmakefile
sed -e "s/GPIO_LIBS=-lwiringPi/GPIO_LIBS=-lwiringPi -lcrypt/" GNUmakefile > tmp.make
mv tmp.make GNUmakefile
#
# -----------------------------------------
# Download libsoundio (needed for linhpsdr)
# -----------------------------------------
#
cd $HOME
rm -rf libsoundio
git clone https://github.com/andrewrk/libsoundio
#
# -----------------
# Download LinHPSDR
# -----------------
#
cd $HOME
rm -rf linhpsdr
git clone https://github.com/g0orx/linhpsdr
#
# -------------------------------------------------
# Download hamlib
# (needed for fldigi,GUI rig controller, and wsjtx)
# -------------------------------------------------
#
cd $HOME
rm -rf hamlib
git clone https://github.com/dl1ycf/hamlib
#
# ---------------------------
# Download GUI rig controller
# ---------------------------
#
cd $HOME
rm -rf RigCtldGUI
git clone https://github.com/dl1ycf/RigCtldGUI
#
# ---------------
# Download fldigi
# ---------------
#
cd $HOME
rm -rf fldigi
git clone https://git.code.sf.net/p/fldigi/fldigi
#
# --------------
# Download wsjtx
# --------------
#
cd $HOME
rm -rf wsjtx
git clone https://git.code.sf.net/p/wsjt/wsjtx

##########################################################
#
# PART 3: Create Desktop Icons and startup scripts
# ------- for piHPSDR, linHPSDR, fldigi, wsjtx, and
#         the GUI rig controller
#
##########################################################

#
# On some systems, pihpsdr needs to be run with
# root privileges for GPIO access, so invoke it
# via "sudo"
#
cat > $HOME/pihpsdr/pihpsdr.sh << '#EOF'
#!/bin/sh
cd $HOME/pihpsdr
rm -f hpsdr.png
cp release/pihpsdr/hpsdr.png hpsdr.png
sudo ./pihpsdr >pihpsdr.log 2>&1
#EOF
chmod 755 $HOME/pihpsdr/pihpsdr.sh

cat > $HOME/linhpsdr/linhpsdr.sh << '#EOF'
#!/bin/sh
cd $HOME/linhpsdr
./linhpsdr >linhpsdr.log 2>&1
#EOF
chmod 755 $HOME/linhpsdr/linhpsdr.sh

cat > $HOME/Desktop/fldigi.desktop << '#EOF'
[Desktop Entry]
Name=Fldigi
Icon=/home/pi/fldigi/data/fldigi-psk.png
Exec=/home/pi/fldigi/src/fldigi
Type=Application
Terminal=false
StartupNotify=true
#EOF

cat > $HOME/Desktop/wsjtx.desktop << '#EOF'
[Desktop Entry]
Name=wsjtx
Icon=/home/pi/wsjtx/icons/Unix/wsjtx_icon.png
Exec=/home/pi/wsjtx/bin/wsjtx
Type=Application
Terminal=false
StartupNotify=true
#EOF

cat > $HOME/Desktop/RigCtl.desktop << '#EOF'
[Desktop Entry]
Name=RigCtl
Icon=/home/pi/RigCtldGUI/RigCtl.icns
Exec=/home/pi/RigCtldGUI/RigCtl
Type=Application
Terminal=false
StartupNotify=true
#EOF

cat > $HOME/Desktop/pihpsdr.desktop << '#EOF'
[Desktop Entry]
Name=piHPSDR
Icon=/home/pi/pihpsdr/release/pihpsdr/hpsdr_icon.png
Exec=/home/pi/pihpsdr/pihpsdr.sh
Type=Application
Terminal=false
StartupNotify=true
#EOF

cat > $HOME/Desktop/linhpsdr.desktop << '#EOF'
[Desktop Entry]
Name=LinHPSDR
Icon=/home/pi/linhpsdr/hpsdr_icon.png
Exec=/home/pi/linhpsdr/linhpsdr.sh
Type=Application
Terminal=false
StartupNotify=true
#EOF

##########################################################
#
# PART 4: Tweaking the operating system
# -------
##########################################################


###########################################################################
#
#  Create loopback sound devices (virtual audio cables)
#  that you can use to transport audio from/to wsjtx and fldigi
#  They appear as sound cards with index 4 and 5 and name vac1 and vac2.
#
###########################################################################
#
sudo modprobe snd-aloop enable=1,1 index=4,5 id=vac1,vac2 pcm_substreams=2,2
#
# Make this permanent
#
cat > etc_rc.local << '#EOF'
#!/bin/sh -e
#

modprobe snd-aloop enable=1,1 index=4,5 id=vac1,vac2 pcm_substreams=2,2
exit 0
#EOF
sudo cp etc_rc.local /etc/rc.local


###########################################################################
#
# Create a fixed IP address
#
# If not connected to DHCP, the computer will use a fixed IP address
# (192.168.1.50 in this example).
# If your radio has a fixed IP address in the same subnet, this
# makes it easy to use the radio with a direct cable between RaspPi and radio
#
###########################################################################
#
cat > etc_network_eth0 << '#EOF'
auto eth0
  iface eth0 inet static
  address 191.168.1.50
  netmask 255.255.255.0
  gateway 192.168.1.1
  dns-nameservers 192.168.1.1
#EOF
sudo cp etc_network_eth0 /etc/network/interfaces.d/eth0

###########################################################################
#
# GPIO-related stuff
#
# Even the latest version of wiringpi does not fully support the RPi 4
#
# Therefore, set all the GPIO pins to "input with pull-up"
#
###########################################################################
#
cat > boot_config.txt << '#EOF'
######################################
# setup GPIO pins start
######################################
gpio=4-27=ip,pu
######################################
# setup GPIO pins end
######################################
#EOF
cat /boot/config.txt >> boot_config.txt
sudo cp boot_config.txt /boot/config.txt


###########################################################################
#
# ALL DONE. It is a good idea to reboot the system now to make some
#           changes (network, GPIO) effective.
#           Then, compile the sources using the script compile.sh
#        
###########################################################################
