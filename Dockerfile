FROM amd64/ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && apt install -y \
  strace gdb gdb-multiarch gcc gdbserver \
  libc6-dbg gcc-multilib g++-multilib curl wget make python3 \
  python3-pip vim binutils ruby ruby-dev netcat tmux \
  file less man jq lsof tree iproute2 iputils-ping iptables dnsutils \
  traceroute nmap socat p7zip-full git net-tools openssh-server

RUN python3 -m pip install --upgrade pip && \
  python3 -m pip install pwntools keystone-engine && \
  git clone https://github.com/pwndbg/pwndbg && \
  gem install one_gadget

# Editor Config
RUN echo "set number\nsyntax on" >> ~/.vimrc && \
 echo "set -g mouse on" >> ~/.tmux.conf

WORKDIR /ctf

COPY dbg-test.c /ctf

ENV TERM=xterm-256color
ENV SHELL=/bin/bash
ENV LANG=C.UTF-8

CMD ["tmux"]