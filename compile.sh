#!/bin/sh
###################################################
#  This cleans up everything in the source code
#  directories, updates all downloaded source code
#  trees, and recompiles everything.
#
#  NOTE: the OS is not upgraded since the system
#        should be re-booted at least if the kernel
#        has been upgraded.
###################################################

# number of CPUs to use in parallel make
export NPROCS=4


###################################################
#
# clean up everything
#
###################################################
#
make -C $HOME/pihpsdr    clean
make -C $HOME/wdsp       clean
make -C $HOME/linhpsdr   clean
make -C $HOME/hamlib     clean
make -C $HOME/RigCtldGUI clean
make -C $HOME/fldigi     clean
#
rm -rf $HOME/SoapySDR/build
rm -rf $HOME/libiio/build
rm -rf $HOME/SoapyPlutoSDR/build
rm -rf $HOME/libsoundio/build
rm -rf $HOME/wsjtx/build
rm -rf $HOME/wsjtx/bin
rm -rf $HOME/wsjtx/share

###################################################
#
# Update, compile and install WDSP
#
###################################################

cd $HOME/wdsp
git pull
make clean
make -j $NPROCS
sudo make install
sudo ldconfig

###################################################
#
# Update, compile and install SoapySDR core
#
###################################################

cd $HOME/SoapySDR
git pull
rm -rf build
mkdir build
cd build
cmake ..
make -j $NPROCS
sudo make install
sudo ldconfig

###################################################
#
# Update, compile and install libiio
#
###################################################

cd $HOME/libiio
git pull
rm -rf build
mkdir build
cd build
cmake ..
make -j $NPROCS
sudo make install
sudo ldconfig

###################################################
#
# Update, compile and install the
# SoapySDR Pluto module
#
###################################################

cd $HOME/SoapyPlutoSDR
git pull
rm -rf build
mkdir build
cd build
cmake ..
make -j $NPROCS
sudo make install

###################################################
#
# Update and compile piHPSDR
#
###################################################

cd $HOME/pihpsdr
git pull
make clean
make -j $NPROCS

###################################################
#
# Update, compile and install libsoundio
# (needed for linhpsdr)
#
###################################################

cd $HOME/libsoundio
git pull
rm -rf build
mkdir build
cd build
cmake ..
make -j $NPROCS
sudo make install
sudo ldconfig

###################################################
#
# Update and compile linhpsdr
#
###################################################

cd $HOME/linhpsdr
git pull
make -j $NPROCS

###################################################
#
# Update, compile and install hamlib
#
###################################################

cd $HOME/hamlib
git pull
make clean
autoreconf -i
./configure
make -j $NPROCS
sudo make install
sudo ldconfig

###################################################
#
# Update and compile "rigctl" with GUI
#
###################################################

cd $HOME/RigCtldGUI
git pull
make clean
make -j $NPROCS

###################################################
#
# Update and compile fldigi
#
# Note: I always have problems with the
#       national language support
#       therefore I switch it off
#
#       "confdialog" needs MUCH memory to compile
#       so use only one CPU otherwise compilation
#       may fail due to memory shortage!
#       (this is the case on 64-bit systems with gcc9)
#
###################################################

cd $HOME/fldigi
git pull
make clean
autoreconf -i
./configure --disable-flarq --disable-nls
make

###################################################
#
# Update and compile wsjtx
#
# Skip generation of documentation and man pages 
# since we need TONS of further software
# (asciidoc, asciidoctor, texlive ...) 
# to do so.
#
###################################################

cd $HOME/wsjtx
rm -rf build bin share
export CC=gcc
export CXX=g++
export FC=gfortran
mkdir bin
TARGET=$PWD
CMFLG="-DWSJT_GENERATE_DOCS=OFF -DWSJT_SKIP_MANPAGES=ON"
rm -rf build
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$TARGET $CMFLG ..
cd ..
cmake --build build --target install -j $NPROCS

