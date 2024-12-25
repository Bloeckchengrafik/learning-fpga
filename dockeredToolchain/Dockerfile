FROM debian:latest

RUN apt update && apt install -y build-essential curl iverilog clang lld bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git python3-pip \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev nodejs

WORKDIR /opt/yosys
RUN git clone --recurse-submodules https://github.com/YosysHQ/yosys.git .
RUN make config-gcc
RUN make
RUN make install

RUN pip install apycula --break-system-packages

RUN apt install cmake libboost-dev libboost-filesystem-dev libboost-thread-dev libeigen3-dev python3-dev libboost-program-options-dev libboost-iostreams-dev libboost-dev -y

WORKDIR /opt/pnr
RUN git clone https://github.com/YosysHQ/nextpnr . 
RUN cmake . -DARCH="himbaechel" -DHIMBAECHEL_GOWIN_DEVICES="all" 
RUN make -j$(nproc) 
RUN make install 

WORKDIR /app

COPY files/docker-entrypoint.sh /app
CMD [ "bash", "docker-entrypoint.sh" ]