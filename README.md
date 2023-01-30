# Script to setup a PC workstation

## Usage

- Download & extract: `curl -Lo setup.zip https://github.com/titouanlacombe/setup-script-personal/archive/refs/heads/main.zip && unzip setup.zip -d setup-script && rm setup.zip`
- Go to the extracted folder `cd setup-script`
- Edit config.sh
- Execute `./main.sh`

## Docker usage

Create a container, enter it and test setup with:
- `docker-compose up -d <distro>`
- `docker exec -it <distro> /home/fakeuser/setup/main.sh`
