FROM amd64/ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV SHELL=/bin/bash
ENV LANG=C.UTF-8
ENV PIP_ROOT_USER_ACTION=ignore

RUN apt update -y && apt upgrade -y && apt install -y \
  strace gdb gdb-multiarch gcc gdbserver \
  libc6-dbg gcc-multilib g++-multilib curl wget make python3 \
  python3-pip vim binutils ruby ruby-dev netcat tmux \
  file less man jq lsof tree iproute2 iputils-ping iptables dnsutils \
  traceroute nmap socat p7zip-full git net-tools openssh-server

# PWN config
RUN python3 -m pip install --upgrade pip && \
  python3 -m pip install pwntools keystone-engine && \
  git clone https://github.com/pwndbg/pwndbg && \
  gem install one_gadget

# Editor Config
RUN echo "set number\nsyntax on" >> ~/.vimrc && \
  echo "set -g mouse on" >> ~/.tmux.conf

COPY dbg-test.c background-startup.sh container-startup.sh /

# SSH/startup Config
RUN echo "PermitRootLogin yes\nPasswordAuthentication yes\nPermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
  passwd -d root && \
  chmod +x /container-startup.sh /background-startup.sh

WORKDIR /ctf