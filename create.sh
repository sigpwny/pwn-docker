#!/bin/bash
set -e

docker build . -t sigpwny/pwn-docker

read -p "Would you like to bind $HOME/ctf to /ctf in the container? [y/n] " -n 1 -r reply
echo 	# (optional) move to a new line
if [[ $reply =~ ^[Yy]$ ]]
then
	# Create ~/ctf if it doesn't exist
	mkdir -p ~/ctf
	# Create the container
	# RUN mount -t virtiofs rosetta /media/rosetta

	docker run -it \
		--volume="$HOME/ctf:/ctf:rw" \
		--security-opt seccomp=unconfined \
		--cap-add=SYS_PTRACE \
		--privileged \
		-p 1234:1234 \
		--name pwn-docker \
		sigpwny/pwn-docker
else
	echo "Creating temporary container, changes will not be saved."
	docker run -it --rm \
		--volume="`pwd`:/ctf:rw" \
		--security-opt seccomp=unconfined \
		--cap-add=SYS_PTRACE \
		--privileged \
		-p 1234:1234 \
		sigpwny/pwn-docker
fi
