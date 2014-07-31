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

#Cuda Installation(without installing NVIDIA-display driver) 
#Toolkit:  Installed in /usr/local/cuda-6.0
#Samples:  Installed in /usr/local/cuda-6.0/samples
#Please make sure that
# -   PATH includes /usr/local/cuda-6.0/bin
# -   LD_LIBRARY_PATH includes /usr/local/cuda-6.0/lib64, or, add /usr/local/cuda-6.0/lib64 to /etc/ld.so.conf and run ldconfig as root
#To uninstall CUDA, remove the CUDA files in /usr/local/cuda-6.0

sudo ./cuda_6.0.37_linux_64.run --override --silent --toolkit --samples --verbose


## resources :
#1. http://www.sysads.co.uk/2014/05/install-opencv-2-4-9-ubuntu-14-04-13-10/
#2. cv+cuda  http://sn0v.wordpress.com/2012/05/11/installing-cuda-on-ubuntu-12-04/
#3. cv       http://karytech.blogspot.tw/2012/05/opencv-24-on-ubuntu-1204.html


sudo apt-fast install -y build-essential checkinstall cmake pkg-config yasm
sudo apt-fast install -y libtiff4-dev libjpeg-dev libjasper-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libavformat-dev x264 v4l-utils ffmpeg python-opencv opencv-doc libcv-dev libcvaux-dev libhighgui-dev libgtk2.0-dev libjpeg-dev libtiff4-dev libjasper-dev libopenexr-dev cmake python-dev python-numpy python-tk libtbb-dev libeigen2-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libqt4-dev libqt4-opengl-dev sphinx-common texlive-latex-extra libv4l-dev libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev

sudo apt-fast install -y libopencv-dev build-essential checkinstall cmake pkg-config yasm libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils

##install ffmpeg
###for 14.04 only 
##remove old installation 
## sudo apt-get -qq remove ffmpeg x264 libx264-dev
# sudo add-apt-repository -y ppa:mc3man/trusty-media && sudo apt-fast -y update &&  apt-fast install -y ffmpeg gstreamer0.10-ffmpeg

### for 13.10 
## sudo apt-fast install -y ffmpeg gstreamer0.10-ffmpeg

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
###with no CUDA
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON ..

# we can use -DCMAKE_INSTALL_PREFIX=/usr or some other path to customise installation of the library. by default the path is 
cmake -D CMAKE_INSTALL_PREFIX=/usr/local -D CMAKE_BUILD_TYPE=RELEASE -D WITH_XINE=ON -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_CUBLAS=ON -D WITH_CUDA=ON -D WITH_OPENGL=ON -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda/  .. 
###make the opencv
make -j
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


######## Tesseract Installation
##Install Prerequiste software
sudo apt-fast install -y libpng-dev libjpeg-dev libtiff-dev zlib1g-dev gcc g++ autoconf automake libtools checkinstall
##Install Leptonica 1.70 library
wget http://www.leptonica.org/source/leptonica-1.70.tar.gz
tar -zxvf leptonica-1.70.tar.gz
cd leptonica-1.70
./configure
make -j
sudo checkinstall
sudo ldconfig

## Install Tesseract 3.02.02
#defalut path for libraries /usr/local/lib
sudo apt-fast install -y autoconf automake libtool libpng12-dev libjpeg62-dev libtiff4-dev zlib1g-dev libicu-dev libpango1.0-dev libcairo2-dev

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



##Tesseract library path : /usr/local/include/tesseract
##OpenCV library path : opencv/build/api



#tesseract 3.03
#Download and unzip from here :https://drive.google.com/folderview?id=0B7l10Bj_LprhQnpSRkpGMGV2eE0&usp=sharing#list
sudo apt-fast install -y libicu-dev libpango1.0-dev libcairo2-dev
tar xfv tesseract-ocr-3.02.eng.tar.gz 
cd tesseract-3.03
./autogen.sh
./configure
make
cd java
make ScrollView.jar
cd ..
export TESSDATA_PREFIX=$PWD/
export SCROLLVIEW_PATH=$PWD/java
#copy the tess


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

