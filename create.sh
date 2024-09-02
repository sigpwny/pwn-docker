#!/bin/bash
set -e

docker build --platform=linux/amd64 . -t sigpwny/pwn-docker

read -p "Would you like to bind $HOME/ctf to /ctf in the container? [y/n] " -n 1 -r reply
echo

read -p "Would you like to start in the background? [y/n] " -n 1 -r background
echo

if [[ $background =~ ^[Yy]$ ]]
then
	background="-d"
else
	background=""
fi

if [[ $reply =~ ^[Yy]$ ]]
then
	if [ ! -d "$HOME/ctf" ]; then
		echo "Creating ~/ctf"
		mkdir -p ~/ctf
	fi
	volume="-v $HOME/ctf:/ctf:rw"
else
	volume="-v `pwd`:/ctf:rw"
fi

docker run -it \
	$volume \
	--security-opt seccomp=unconfined \
	--cap-add=SYS_PTRACE \
	-p 1234:1234 \
	-p 2222:22 \
	--name pwn-docker \
	sigpwny/pwn-docker $background

if [[ $background =~ ^[Yy]$ ]]
then
	echo "Started pwn-docker in the background"
	echo "ssh -p 2222 root@localhost"
fi