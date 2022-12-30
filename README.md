# Script to setup a PC workstation

To use:
- Edit user variables in main.sh
- `cat ./distros/<distro>.sh main.sh | sh`

Create a container & enter it with:
- `docker-compose up -d`
- `docker exec -it <distro> /bin/bash`
- `cat ./distros/<distro>.sh main.sh | sh`
