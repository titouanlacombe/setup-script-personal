# Script to setup a PC workstation

## Usage

```
curl -sL https://github.com/titouanlacombe/setup-script-personal/archive/refs/heads/main.zip -o temp.zip && \
unzip temp.zip && \
rm temp.zip && \
pushd setup-script-personal-main/src && \
./main.sh && \
popd && \
rm -rf setup-script-personal-main
```

## Docker usage

Create a container and enter it and test setup with:
- `docker-compose up -d <distro>`
- `docker exec -it <distro> /home/fakeuser/setup/main.sh`

For example:

`docker-compose up -d ubuntu && docker exec -it ubuntu /home/fakeuser/setup/main.sh`
