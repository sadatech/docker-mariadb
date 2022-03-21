cls
docker rm -f Ubuntu-MariaDB
docker rmi -f sadaindonesia/ubuntu-mariadb:0242ac120003
docker build --pull --rm -f ".\Dockerfile" -t sadaindonesia/ubuntu-mariadb:0242ac120003 "."
docker run -d -it --name Ubuntu-MariaDB -p 3360:3360 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged sadaindonesia/ubuntu-mariadb:0242ac120003
pause