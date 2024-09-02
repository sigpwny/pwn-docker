# Check if pwn-docker exists
if [ "$(docker ps -a | grep pwn-docker)" ]; then
  docker start pwn-docker
  docker exec -it pwn-docker tmux
else
  echo "pwn-docker does not exist (Did you run start.sh?)"
fi
