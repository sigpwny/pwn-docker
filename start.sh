#!/bin/bash
docker pull sigpwny/pwn-docker:latest

read -p "Would you like to bind $HOME/ctf to /ctf in the container? [y/n] " -n 1 -r reply
echo 	# (optional) move to a new line
if [[ $reply =~ ^[Yy]$ ]]
then
	# Create ~/ctf if it doesn't exist
	mkdir -p ~/ctf
	# Create the container
	docker run -it \
		--volume="$HOME/ctf:/ctf:rw" \
		--security-opt seccomp=unconfined \
		--network host \
		--name pwn-docker \
		sigpwny/pwn-docker:latest
else
	echo "Creating temporary container, changes will not be saved."
	docker run -it --rm \
		--volume="`pwd`:/ctf:rw" \
		--security-opt seccomp=unconfined \
		--network host \
		sigpwny/pwn-docker:latest
fi