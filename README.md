# Script to setup a PC workstation

To use:
- Edit user variables in main.sh
- `cat <your_distro>.sh main.sh | sh`

The Dockerfile is to test setup.sh on multiple environments and benchmark time & storage
- `docker build --build-arg distro=<image> --build-arg tag=<image_tag> .`

Examples:
- `docker build --build-arg distro=ubuntu --build-arg tag=22.10 .`
- `docker build --build-arg distro=archlinux --build-arg tag=latest .`
- `docker build --build-arg distro=fedora --build-arg tag=37 .`
