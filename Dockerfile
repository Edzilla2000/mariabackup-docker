FROM ubuntu:18.04

LABEL maintainer="Jean Cardona"
LABEL description="Percona XtraBackup - forked from https://github.com/khoanguyen96/dockerfiles/tree/master/percona-xtrabackup"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 wget gnupg \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
    

RUN cd /tmp \
 && wget --no-check-certificate https://repo.percona.com/apt/percona-release_0.1-4.xenial_all.deb \
 && dpkg -i percona* \
 && rm percona*

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 percona-xtrabackup-24 qpress \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# Copy Backup Scripts
COPY scripts/* /usr/local/bin/
RUN chmod +x -R /usr/local/bin

VOLUME /backups/mysql /etc/mysql
WORKDIR /backups/mysql
SHELL ["/bin/bash", "-c"]
