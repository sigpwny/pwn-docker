#!/bin/bash
set -e

docker build --platform=linux/amd64 . -t sigpwny/pwn-docker

read -p "Would you like to bind $HOME/ctf to /ctf in the container? [y/n] " -n 1 -r reply
echo

read -p "Would you like to start in the background? [y/n] " -n 1 -r background
echo

if [[ $background =~ ^[Yy]$ ]]
then
	background_flag="-d"
	command='/background-startup.sh'
else
	background_flag=""
	command='/container-startup.sh'
fi

if [[ $reply =~ ^[Yy]$ ]]
then
	if [ ! -d "$HOME/ctf" ]; then
		echo "Creating ~/ctf"
		mkdir -p ~/ctf
	fi
	volume="-v $HOME/ctf:/ctf:rw"
	destroy=""
else
	volume="-v `pwd`:/ctf:rw"
	destroy="--rm"
fi

echo $background_flag

docker run --interactive -t \
	$volume \
	$destroy \
	--security-opt seccomp=unconfined \
	--cap-add=SYS_PTRACE \
	-p 1234:1234 \
	-p 2222:22 \
	--name pwn-docker \
	sigpwny/pwn-docker \
	$command \
	$background_flag

if [[ $background =~ ^[Yy]$ ]]
then
	echo "Started pwn-docker in the background"
	echo "ssh -p 2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost"
fi