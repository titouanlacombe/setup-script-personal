docker system prune -a -f

docker build --build-arg distro=ubuntu --build-arg tag=latest -t workstation_ubuntu .
docker build --build-arg distro=archlinux --build-arg tag=latest -t workstation_archlinux .
docker build --build-arg distro=fedora --build-arg tag=latest -t workstation_fedora .

docker history workstation_ubuntu
docker history workstation_archlinux
docker history workstation_fedora

docker system prune -a -f
