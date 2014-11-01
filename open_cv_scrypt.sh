http://siddhantahuja.wordpress.com/2011/08/15/ros-opencv-read-a-video-file-using-ffmpeg/

#The MIT License (MIT)
#
#Copyright (c) 2014 TollMeQuick.com 
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
#Authors
#Pranay Sharma : pranaysharma(me@pranays.com)
#Website: 	 www.pranaysharma.in
#Linkedin: 	 www.linkedin.com/tw/pranaysharma

##GPU ACCLERATION (#1 CUDA  'OR'  #2 AMD OPENCL and math libraries)

#1 CUDA
#Cuda Installation(installition of CUDA is done without installitng the  NVIDIA-display driver. Its assumed that the display drivers has already been installed) 
#Toolkit:  Installed in /usr/local/cuda-6.0
#Samples:  Installed in /usr/local/cuda-6.0/samples
#Please make sure that
# -   PATH includes /usr/local/cuda-6.0/bin
# -   LD_LIBRARY_PATH includes /usr/local/cuda-6.0/lib64, or, add /usr/local/cuda-6.0/lib64 to /etc/ld.so.conf and run ldconfig as root
#To uninstall CUDA, remove the CUDA files in /usr/local/cuda-6.0

sudo ./cuda_6.0.37_linux_64.run --override --silent --toolkit --samples --verbose

#2 AMD OPENCL and MAth libraries
## Get the AMD SDK
	# http://developer.amd.com/tools-and-sdks/opencl-zone/amd-accelerated-parallel-processing-app-sdk/#
## Get the ADL 
	# http://developer.amd.com/tools-and-sdks/graphics-development/display-library-adl-sdk/
##you can follow the guide mentioned on VTC website https://vertcoin.org/Ubuntu13-10_headless_howto.html#exchanges for sdk and adl installation
sudo su

bunzip2 AMD-APP-SDK-linux-v2.9-1.599.381-GA-x64.tar.bz2
tar zxvf AMD-APP-SDK-linux-v2.9-1.599.381-GA-x64.tar -C /opt
cd /opt
chmod +x AMD-APP-SDK-v2.9-1.599.381-GA-linux64.sh
./AMD-APP-SDK-v2.9-1.599.381-GA-linux64.sh
reboot

 libavcodec-dev libavformat-dev libcv-dev libcvaux-dev libhighgui-dev
  libopencv-contrib-dev libopencv-highgui-dev libopencv-legacy-dev
  libopencv-objdetect-dev libopencv-ocl-dev

##download and install AMD math libraries (clAmdBlas and clAmdFFT)
	# http://developer.amd.com/tools-and-sdks/opencl-zone/amd-accelerated-parallel-processing-math-libraries/
mkdir amd_math_libraries
tar zxvf clAmdBlas-1.10.321-Linux.tar.gz -c amd_math_libraries/
tar zxvf clAmdFft-1.10.321.tar.gz -C amd_math_libraries/
cd amd_math_libraries
sudo ./install-clAmdBlas-1.10.321.sh
##manually finish the installation: everything remains default
sudo ./install-clAmdFft-1.10.321.sh
##manually finish the installation: everything remains default

##install ffmpeg
##BUild and install LibFFmpeg & Yasm &vpx-dev
sudo apt-fast update
sudo apt-fast -y install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
  libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev yasm libx264-dev libmp3lame-dev libopus-dev

#libx264 
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
./configure --enable-static --enable-pic
make -j7
sudo make install -j7

#install libfdk-aac
wget -O fdk-aac.zip https://github.com/mstorsjo/fdk-aac/zipball/master
unzip fdk-aac.zip
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --disable-shared
make -j7
sudo make install -j7

wget https://github.com/mstorsjo/fdk-aac/archive/v0.1.3.zip
unzip v0.1.3.zip
cd fdk-aac-0.1.3
autoreconf -fiv
./configure --enable-shared
make -j7
sudo make install -j7


# Install libvpx
wget http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
tar xjvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
./configure --disable-examples
make -j7
sudo make install -j7


# Download and install ffmpeg without opencl support(down download the snapshot from git as that might have errors)
wget http://ffmpeg.org/releases/ffmpeg-2.4.2.tar.bz2
tar xjvf ffmpeg-2.4.2.tar.bz2
cd ffmpeg-2.4.2
./configure \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-nonfree \
  --enable-x11grab \
  --enable-pic \
  --enable-shared
make -j7
sudo make install -j7
make distclean
hash -r

## resources :
#1. http://www.sysads.co.uk/2014/05/install-opencv-2-4-9-ubuntu-14-04-13-10/
#2. cv+cuda  http://sn0v.wordpress.com/2012/05/11/installing-cuda-on-ubuntu-12-04/
#3. cv       http://karytech.blogspot.tw/2012/05/opencv-24-on-ubuntu-1204.html


sudo apt-fast install -y build-essential checkinstall cmake pkg-config yasm
sudo apt-fast install -y libtiff4-dev libjpeg-dev libjasper-dev python-dev  libtbb-dev libqt4-dev libgtk2.0-dev x264 v4l-utils libcv-dev libcvaux-dev libhighgui-dev libgtk2.0-dev libjpeg-dev libtiff4-dev libopenexr-dev cmake python-dev python-numpy python-tk libeigen3-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libx264-142 libqt4-dev libqt4-opengl-dev sphinx-common texlive-latex-extra libv4l-dev libdc1394-22-dev  libswscale-dev libpng-dev libjpeg-dev libtiff-dev libwebp-dev python-sphinx texlive

sudo apt-fast install -y build-essential checkinstall cmake pkg-config yasm libjpeg-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils


# fix for 
# 1. http://stackoverflow.com/questions/16321616/opencv-2-4-5-make-error
# 2. http://www.ozbotz.org/opencv-installation/

# download the opencv and move it to ~/worksapce/tools
#notes: download the 
wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.9/opencv-2.4.9.zip


mkdir workspace  
mkdir workspace/tools
mv opencv-2.4.9.zip ~/workspace/tools/
cd ~/workspace/tools/
unzip opencv-2.4.9.zip
cd opencv-2.4.9
mkdir build
cd build
###with no CUDA(need to try this with -D WITH_XINE=ON)
cmake -D CMAKE_INSTALL_PREFIX=/usr/local -D CMAKE_BUILD_TYPE=RELEASE -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_EIGEN=ON -D BUILD_DOCS=ON  -D WITH_CUDA=OFF -D WITH_CUFFT=OFF ..

# with CUDA
#we can use -DCMAKE_INSTALL_PREFIX=/usr or some other path to customise installation of the library. by default the path is 
cmake -D CMAKE_INSTALL_PREFIX=/usr/local -D CMAKE_BUILD_TYPE=RELEASE -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENCL=ON -D WITH_EIGEN=ON -D BUILD_DOCS=ON -D WITH_CUBLAS=ON -D WITH_CUDA=ON -D WITH_OPENGL=ON -D WITH_XINE=ON -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda/   -D BUILD_opencv_gpu=ON -D BUILD_opencv_gpuarithm=ON .. 

#with AMD opencl
#Refrence : http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/07/opencv-cl_instructions-246.pdf
#
cmake -D CMAKE_INSTALL_PREFIX=/usr/local -D CMAKE_BUILD_TYPE=RELEASE -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_XINE=ON -D WITH_EIGEN=ON -D BUILD_DOCS=ON  -D WITH_CUDA=OFF -D WITH_CUFFT=OFF -D WITH_OPENCLAMDBLAS=ON -D CLAMDBLAS_ROOT_DIR=/opt/clAmdBlas-1.10.321 -D WITH_OPENCLAMDFFT=ON  -D CLAMDFFT_ROOT_DIR=/opt/clAmdFft-1.10.321 -D OPENCL_ROOT_DIR=/opt/AMDAPPSDK-2.9-1 -D BUILD_opencv_gpu=ON ..

https://github.com/i-rinat/libvdpau-va-gl

###make the opencv
make -j7
### INstall opencv
sudo make install -j

#Finally, make sure that your programs can link to the OpenCV library in run-time by adding the following line at the end of your /etc/ld.so.conf: 
sudo echo "/usr/local/lib" >>  /etc/ld.so.conf
#configure dynamic linker run-time bindings
sudo ldconfig
##test 
cd build/bin
./opencv_test_core

PS1="\[\033[0;34m\][\u@\h:\w]$\[\033[0m\]"
installation direcory :/usr/local/cuda-6.0
symplink: /usr/local/cuda


######## Tesseract Installation: to remove dpkg -r leptonica
##Install Prerequiste software
sudo apt-fast install -y libpng-dev libjpeg-dev libtiff-dev zlib1g-dev gcc g++ autoconf automake libto checkinstall
##Install Leptonica 1.70 librhttps://github.com/i-rinat/libvdpau-va-glary
wget http://www.leptonica.org/source/leptonica-1.70.tar.gz
tar -zxvf leptonica-1.70.tar.gz
cd leptonica-1.70
./configure
make -j
sudo checkinstall
sudo ldconfig

## Install Tesseract 3.02.02
#defalut path for libraries /usr/local/lib
#sudo apt-fast install -y autoconf automake libtool libpng12-dev libjpeg62-dev libtiff4-dev zlib1g-dev libicu-dev libpango1.0-dev libcairo2-dev

wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz
tar xvf tesseract-ocr-3.02.02.tar.gz
cd tesseract-ocr
./autogen.sh
./configure
make -j 
sudo make install -j 
sudo ldconfig

#Instll libraries
cd ../
mkdir libraries_tesseract
cd libraries_tesseract
wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz
tar xvf tesseract-ocr-3.02.eng.tar.gz
export TESSDATA_PREFIX=/usr/local/share/
###now copy the libraries to the tessdata folder
cd tesseract-ocr/tessdata
sudo mv *.* /usr/local/share/tessdata/


https://github.com/i-rinat/libvdpau-va-gl
##Tesseract library path : /usr/local/include/tesseract
##OpenCV library path : opencv/build/api



#tesseract 3.03 with english language 
#Download and unzip from here :https://drive.google.com/folderview?id=0B7l10Bj_LprhQnpSRkpGMGV2eE0&usp=sharing#list
sudo apt-fast install -y libicu-dev libpango1.0-dev libcairo2-dev
tar xfv tesseract-3.03-rc1.tar
#extract tesseract's english data pack to tessdata directory of tesseract-3.03. Assuming both are in the same folder
tar zxvf tesseract-ocr-3.02.eng.tar.gz
mv tesseract-ocr/tessdata/*.* tesseract-3.03/tessdata/
cd tesseract-3.03

#./autogen.sh --> uses configure.ac as an input file. So the AMDSDK path needs to be changed there
./autogen.sh


# To enable OpenCL 
#1. change the line "OPENCL_INC="/opt/AMDAPP/include" in "configure.ac" to point towards
     #  the correct AMDAPP(or amd SDK) directory(for 2.9 version of sdk OPENCL_INC="/opt/AMDAPPSDK-2.9-1/include"). 
     #  So you need to install AMD SDK inorer to enable GPU accleration
#2. ./configure ----enable-opencl 
     # Refrence:  http://www.sk-spell.sk.cx/tesseract-meets-the-opencl-first-test     

./configure
make -j
sudo make install LANGS="eng"

cd java
make ScrollView.jar
cd ..
export TESSDATA_PREFIX=$PWD/
export SCROLLVIEW_PATH=$PWD/java
#copy the tess

Training tools can be build and installed (after building of tesseract) with:

make training
sudo make training-install

-----------
####open alpr
cd /usr/local/src/
sudo mkdir openalpr
cd openalpr
sudo git clone https://github.com/openalpr/openalpr.git
cd openalpr/src
# edit cmake file to point to correct paths 
##SET(Tesseract_DIR "/usr/local/include/tesseract")
##SET(OpenCV_DIR "/usr/local/lib")
cmake ./
make -j
make install
#load the libraries
sudo ldconfig
#edit the runtime directory
sudo emacs /etc/openalpr/openalpr.conf
## might have to change the 'leu' to the tesseract language you want(eng)
## WOULD have to change the runtime directory path. We set it to 
##/usr/local/src/openalpr/openalpr/runtime_dir

#for tesseract 3.03 and the new code
#change copy tesseract-3.03/tessdata and the language packs to openalpr/runtime_dir/ocr/tessdata

------------------openlpr requisites-----
##log4cplus:  download from http://sourceforge.net/projects/log4cplus/files/log4cplus-stable/1.2.0/
unzip log4cplus-1.2.0-rc2
cd log4cplus-1.2.0-rc2
./configure
make -j
sudo make install
sudo ldconfig
#beanstalk deamon, uuid library, log4cplus library
sudo apt-fast install -y beanstalkd uuid-dev liblog4cplus-dev







