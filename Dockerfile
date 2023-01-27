FROM amd64/ubuntu:22.04

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y strace gdb gdb-multiarch gcc gdbserver \
  libc6-dbg gcc-multilib g++-multilib curl wget make python3 \
  python3-pip vim binutils ruby ruby-dev netcat tmux \
  file less man jq lsof tree iproute2 iputils-ping iptables dnsutils \
  traceroute nmap socat p7zip-full git

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install pwntools keystone-engine

# GDB
RUN bash -c "$(curl -fsSL https://gef.blah.cat/sh)"
RUN gem install one_gadget
RUN echo "set confirm off" >> ~/.gdbinit
RUN echo "set pagination off" >> ~/.gdbinit
RUN echo "set disassembly-flavor intel" >> ~/.gdbinit

# Editor Config
RUN echo "set number\nsyntax on" >> ~/.vimrc
RUN echo "set -g mouse on" >> ~/.tmux.conf

WORKDIR /ctf

ENV TERM=xterm-256color
ENV SHELL=/bin/bash
ENV LANG=C.UTF-8

CMD tmux