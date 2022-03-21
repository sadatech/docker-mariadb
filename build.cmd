cls
docker rm -f Ubuntu-MariaDB-Bionic
docker rmi -f sadaindonesia/ubuntu-mariadb:0242ac120003
docker build --pull --rm -f ".\Dockerfile" -t sadaindonesia/ubuntu-mariadb:0242ac120003 "."
docker run -d -it --name Ubuntu-MariaDB-Bionic -e MARIADB_ROOT_PASSWORD=ayamgoreng -p 3360:3360 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v mariadb-data:/var/lib/mysql --privileged sadaindonesia/ubuntu-mariadb:0242ac120003
pause