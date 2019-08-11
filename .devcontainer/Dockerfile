#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

FROM debian:9

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils 2>&1 \
    # 
    # Verify git, process tools, lsb-release (useful for CLI installs) installed
    && apt-get -y install git procps lsb-release \
    #
    # Install C++ tools
    && apt-get -y install build-essential gcc g++ cmake cppcheck valgrind ninja-build \
      wget git libtool libssl-dev libboost-all-dev libjansson-dev libuv1-dev\
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Download boost, untar, setup install with bootstrap and only do the Program Options library,
# and then install
# RUN cd /home && wget http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.gz \
#   && tar xfz boost_1_60_0.tar.gz \
#   && rm boost_1_60_0.tar.gz \
#   && cd boost_1_60_0 \
#   && ./bootstrap.sh --prefix=/usr/local --with-libraries=program_options,system,filesystem \
#   && ./b2 install \
#   && cd /home \
#   && rm -rf boost_1_60_0

# Download wampcc
#
RUN cd /home && git clone https://github.com/darrenjs/wampcc.git wampcc \
  && cd wampcc \
  && mkdir wampcc-release \
  && cd wampcc-release \
  && cmake ../ -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DLIBUV_DIR=/opt/libuv-1.10.2 \
      -DJANSSON_DIR=/opt/jansson-2.10 \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
  && make

RUN git clone -q https://github.com/google/googletest.git /googletest \
  && mkdir -p /googletest/build \
  && cd /googletest/build \
  && cmake .. && make && make install \
  && cd / && rm -rf /googletest
  
# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog