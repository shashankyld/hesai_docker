# Starting Here
FROM ros:noetic-ros-base-focal

RUN apt-get update

    # Utilitaires
RUN apt-get install -y \
    git \
    cmake \
    wget \
    tar \
    libx11-dev \
    xorg-dev \
    libssl-dev \
    build-essential \
    libusb-1.0-0-dev \
    libglu1-mesa-dev \
    net-tools \
    iputils-ping 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  \
    libpcl-dev  \
    libpcap-dev -y \
    libboost-dev -y \
    libyaml-cpp-dev \
    python3-pip -y \
    python3-rosdep -y \
    vim -y 


RUN apt install libeigen3-dev

RUN pip3 install -U catkin_tools
RUN pip3 install -U rosdep  

RUN rosdep update

RUN mkdir workspace
WORKDIR /workspace

RUN echo "Installing Eigen 3 last version ..." && \
    #-> Linear algebra library
    apt-get install -y libeigen3-dev


RUN echo "Installing PCL ..." && \
    apt install libpcl-dev && \
    echo "Installing Boost ..." && \
    apt install -y libboost-dev && \
    apt install -y libboost-thread-dev && \
    apt install -y libboost-filesystem-dev 


RUN apt install libpcap-dev libyaml-cpp-dev && \
    apt install libprotobuf-dev protobuf-compiler -y && \
    apt-get install ros-noetic-image-transport -y


RUN mkdir -p rosworkspace/src && \
    cd rosworkspace/src && \
    git clone https://github.com/HesaiTechnology/HesaiLidar_General_ROS.git --recursive

ENV ROS_SETUP_PATH=/opt/ros/noetic/setup.bash

RUN ln -s /usr/include/eigen3/Eigen /usr/include/Eigen


RUN apt-get install  ros-noetic-tf2-tools  ros-noetic-rviz -y

RUN rosdep install --from-paths rosworkspace/src/HesaiLidar_General_ROS --ignore-src -r -y


RUN /bin/bash --login -c "cd rosworkspace && source /opt/ros/noetic/setup.bash && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    source rosworkspace/devel/setup.bash 

