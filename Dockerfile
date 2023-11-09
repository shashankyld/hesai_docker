FROM ros:humble-ros-base-jammy

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
    # cd /usr/local/include/ && \
    # git clone https://gitlab.com/libeigen/eigen.git eigen  && \
    # cd /workspace

# RUN echo "Installing Eigen 3 last version ..." && \
#     #-> Linear algebra library
#     # apt-get install -y libeigen3-dev
#     git clone https://gitlab.com/libeigen/eigen.git eigen && \
#     cd eigen && mkdir build_dir && \
#     cd build_dir && \
#     cmake .. && \
#     make install

# RUN #-> Install Eigen 3 last version && \
#     #-> Linear algebra library
#     echo "Installing Eigen 3 last version ..." && \
#     # apt-get install -y libeigen3-dev
#     apt install -y libeigen3-dev 

RUN echo "Installing PCL ..." && \
    apt install libpcl-dev && \
    echo "Installing Boost ..." && \
    apt install -y libboost-dev && \
    apt install -y libboost-thread-dev && \
    apt install -y libboost-filesystem-dev 


RUN apt install libpcap-dev libyaml-cpp-dev && \
    apt install libprotobuf-dev protobuf-compiler -y && \
    apt-get install ros-humble-image-transport -y




# RUN mkdir -p rosworkspace/src && \
#     cd rosworkspace/src && \
#     git clone --branch ROS2 https://github.com/HesaiTechnology/HesaiLidar_General_ROS.git --recursive

RUN mkdir -p rosworkspace/src && \
    cd rosworkspace/src && \
    git clone --branch ROS2 https://github.com/nrasulnrasul/HesaiLidar_General_ROS.git --recursive


ENV ROS_SETUP_PATH=/opt/ros/humble/setup.bash

RUN ln -s /usr/include/eigen3/Eigen /usr/include/Eigen

# # Installing HesaiLidar_General_SDK
# RUN cd rosworkspace/src/HesaiLidar_General_ROS/src/HesaiLidar_General_SDK && \
#     mkdir build && \
#     cd build && \
#     cmake -DCMAKE_PREFIX_PATH=/workspace/eigen .. && \
#     make 


### REPLACING SUB-DIR SDK WITH INDEPENDENT SDK ###
# RUN cd rosworkspace/src/HesaiLidar_General_ROS/src/ && \
#     rm -rf HesaiLidar_General_SDK && \
#     git clone https://github.com/HesaiTechnology/HesaiLidar_General_SDK.git HesaiLidar_General_SDK


# # Installing HesaiLidar_General_SDK
# RUN cd rosworkspace/src/HesaiLidar_General_ROS/src/HesaiLidar_General_SDK && \
#     mkdir build && \
#     cd build && \
#     cmake .. && \
#     make 

RUN apt-get install ros-humble-turtle-tf2-py ros-humble-tf2-tools ros-humble-tf-transformations ros-humble-rviz2 -y 
RUN rosdep install --from-paths rosworkspace/src/HesaiLidar_General_ROS --ignore-src -r -y

# ## ADDING PCL_CONVERSIONS PACKAGE TO WORKSPACE BEFORE BUILDING
# RUN cd rosworkspace/src/ && \
#     git clone https://github.com/ros-perception/perception_pcl.git perception_pcl

# Install curl
# RUN apt-get update && apt-get install -y curl 

# RUN apt-get update && apt-get install -y curl 
 


# # ## Building PCL from source
# # RUN curl -L -O https://github.com/PointCloudLibrary/pcl/releases/download/pcl-1.13.1/source.tar.gz && \
# #     tar xvf source.tar.gz && \
# #     cd pcl && mkdir build && cd build && \
# #     cmake -DCMAKE_BUILD_TYPE=Release .. && \
# #     make -j2 && \
# #     make -j2 install



RUN /bin/bash --login -c "cd rosworkspace && source /opt/ros/humble/setup.bash && colcon build --symlink-install"

# RUN source /opt/ros/humble/setup.bash