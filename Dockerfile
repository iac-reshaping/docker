FROM ubuntu:22.04

# Install dependencies
RUN apt-get update
RUN apt-get install -y \
    git \ 
    perl \
    python3 \
    python3-pip \
    gperf \
    autoconf \
    bc \
    bison \
    gcc \
    make \
    flex \
    build-essential \
    ca-certificates \
    ccache \
    libgoogle-perftools-dev \
    numactl \
    perl-doc \
    libfl2 \
    libfl-dev \
    zlib1g \
    zlib1g-dev \
    qemu qemu-user \
    gcc-riscv64-unknown-elf

# Install Verilator
WORKDIR /tmp

# hadolint ignore=DL3003
RUN git clone https://github.com/verilator/verilator verilator && \
    cd verilator && \
    git checkout v4.214 && \
    autoconf && \
    ./configure && \
    make -j "$(nproc)" && \
    make install && \
    cd .. && \
    rm -r verilator

RUN mkdir -p /code
RUN mkdir -p /code/cpu

WORKDIR /code/cpu
RUN verilator --version

ENTRYPOINT [ "/bin/bash" ]