cls
docker rm -v -f Ubuntu-MariaDB-Focal
docker rmi -f sadaindonesia/ubuntu-mariadb:0242ac120044
docker build --pull --rm -f ".\Dockerfile" -t sadaindonesia/ubuntu-mariadb:0242ac120044 "."
docker run -d -it --name Ubuntu-MariaDB-Focal -e MARIADB_ROOT_PASSWORD=ayamgoreng -p 3366:3360 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v mariadb-data:/var/lib/mysql --privileged sadaindonesia/ubuntu-mariadb:0242ac120044
pause