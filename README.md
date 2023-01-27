# pwn-docker
A docker container for pwn with sigpwny

## Prereqs

+ Install Docker
+ If you are on Apple Silicon, install version `4.16.0` or above. Then enable 'Use Virtualization Framework' in 'Settings > General' and 'Use Rosetta for x86/amd64 on Apple Silicon' in 'Settings > Features in Development'
## Installation

```
git clone https://github.com/sigpwny/pwn-docker.git
cd pwn-docker
```

## Usage
```
./start.sh
```
Create a container. Type 'y' to bind to ~/ctf and make a non-ephemeral container.

```
./run.sh
```
Connect to the non-ephemeral container if possible.