FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive 

# build tools
RUN apt-get -y update && apt-get install -y \
  build-essential \
  git \
  wget \
  autoconf \
  autogen \
  automake \
  libtool \
  libgl1 \
  libgomp1 \
  python3-pip \
  cmake \
  ccache \
  liblzma-dev \
  libncurses5-dev \
  xorg \
  libx11-dev \
  x11-xserver-utils \
  xorg-dev \
  libglu1-mesa-dev \
  libc++-14-dev \
  libc++abi-14-dev \
  python3-dev \
  python3-pip \
  libdnnl-dev \
  cmake-curses-gui \
  software-properties-common \
  python-dbus-dev \
  python3-tk \
  zenity \
  v4l-utils \
  nano \
  gedit \
  emacs \
  vim \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# RealSense
  RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo jammy main" -u \
    && apt-get update -y \
    && apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

  # download / tensorflow /  build open3d
  RUN pip install -U pip numpy wheel packaging requests opt_einsum \
    && pip install -U keras_preprocessing --no-deps \
    && pip install -U tensorflow~=2.8.2 \
    && pip install torch torchvision torchaudio \
    && pip install nvidia-tensorrt \
    && pip install yapf \
    && pip install jupyterlab

  # build Open3d
  # build 2x so we get cpu and gpu bindings
  RUN git clone https://github.com/isl-org/Open3D \
    && cd Open3D \
    && export SUDO=command \
    && ./util/install_deps_ubuntu.sh assume-yes \
    && cd ../ \
    && git clone https://github.com/isl-org/Open3D-ML.git \
    && cd Open3D \ 
    && rm -rf build \
    && mkdir build \
    && cd build \
    && cmake -DBUILD_CUDA_MODULE=ON \
          -DGLIBCXX_USE_CXX11_ABI=OFF \
          -DBUILD_LIBREALSENSE=ON \
          -DBUILD_PYTORCH_OPS=ON \
          -DBUILD_TENSORFLOW_OPS=ON \
          -DBUNDLE_OPEN3D_ML=ON \
          -DOPEN3D_ML_ROOT=/Open3D-ML \
          -DCMAKE_CUDA_ARCHITECTURES="60;70;80" \
          .. \
    && make -j8 \
    && make -j8 install \
    && make -j8 install-pip-package \
    && cmake -DBUILD_CUDA_MODULE=OFF \
          -DGLIBCXX_USE_CXX11_ABI=OFF \
          -DBUILD_LIBREALSENSE=ON \
          -DBUILD_PYTORCH_OPS=ON \
          -DBUILD_TENSORFLOW_OPS=ON \
          -DBUNDLE_OPEN3D_ML=ON \
          -DOPEN3D_ML_ROOT=/Open3D-ML \
          .. \
    && make -j8 \
    && make -j8 install-pip-package \
    && cd ../../ \
    && rm -rf Open3D* \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

  ENV export NVIDIA_DRIVER_CAPABILITIES=${NVIDIA_DRIVER_CAPABILITIES},graphics,compat32
  ENV export ftp_proxy="http://10.210.15.2:3128"
  ENV export http_proxy="http://10.210.15.2:3128"
  ENV export https_proxy="http://10.210.15.2:3128"
