FROM sadaindonesia/ubuntu-baseline:bionic

# Update package list
RUN apt -y update && \
    apt -y upgrade

# ARG
ARG GPG_KEYS=177F4010FE56CA3336300305F1656F24C74CD1D8
ARG MARIADB_MAJOR=10.7
ARG MARIADB_VERSION=1:10.7.3+maria~bionic
ARG REPOSITORY="http://mirror.dknet.my.id/mariadb/mariadb-10.7.3/repo/ubuntu/ bionic main"

# ENV
ENV GOSU_VERSION 1.14
ENV MARIADB_MAJOR $MARIADB_MAJOR
ENV MARIADB_VERSION $MARIADB_VERSION

# Configure Command
ADD /sources/config /tmp
ADD /sources/commands /tmp
RUN dos2unix /tmp/configure-* && \
    chmod +x /tmp/configure-* && \
    sh -c /tmp/configure-mariadb && \
    sh -c /tmp/configure-openssh

# Clear Temp
RUN rm /etc/timezone && \
    echo "Asia/Jakarta" | sudo tee /etc/timezone && \
    rm -rf /tmp/* && \
    apt -y autoclean && \
    apt -yqq autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    touch /var/log/installed.log && \
    rm /var/log/*.log

# Container Environment
EXPOSE 3306
WORKDIR /home
VOLUME /var/lib/mysql
COPY /sources/healthcheck/healthcheck.sh /usr/local/bin/healthcheck.sh
COPY /sources/entrypoints/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["systemd"]
LABEL maintainer="Andika Muhammad Cahya <andkmc99@gmail.com>"
LABEL container="MariaDB Database Server"