# pwn-docker
A docker container for pwn with sigpwny

## Prereqs

+ Install Docker
+ If you are on Apple Silicon, install version `4.16.0` or above. Then enable 'Use Virtualization Framework' in 'Settings > General' and 'Use Rosetta for x86/amd64 on Apple Silicon' in 'Settings > Features in Development'
+ Note that you must be on MacOS 12.3 or above https://github.com/gyf304/vmcli/issues/30#issuecomment-1066118646
## Installation

```
git clone https://github.com/sigpwny/pwn-docker.git
cd pwn-docker
```

## Usage

```bash
./create.sh
```

Create a container. Type 'y' to bind to ~/ctf and make a non-ephemeral container.

```bash
./connect.sh
```
Connect to the non-ephemeral container if possible.


## Testing debugging

```bash
gcc dbg-test.c -o dbg-test-static -static -g
gcc dbg-test.c -o dbg-test-dynamic -g
ROSETTA_DEBUGSERVER_PORT=1234 ./dbg-test-static
# in a seperate terminal
gdb ./dbg-test-static -ex 'target remote localhost:1234'
```
