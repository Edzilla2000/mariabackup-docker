FROM ubuntu:18.04

LABEL maintainer="Jean Cardona"
LABEL description="Mariadb Mariabackup - forked from https://github.com/khoanguyen96/dockerfiles/tree/master/percona-xtrabackup"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 gnupg software-properties-common wget gnupg \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 \
  0xF1656F24C74CD1D8 \
  && add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.nucleus.be/repo/10.4/ubuntu bionic main' 

RUN cd /tmp \
&& wget --no-check-certificate https://repo.percona.com/apt/percona-release_0.1-4.xenial_all.deb \
&& dpkg -i percona* \
&& rm percona*

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 mariadb-backup qpress\
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# Copy Backup Scripts
COPY scripts/* /usr/local/bin/
RUN chmod +x -R /usr/local/bin

VOLUME /backups/mysql /etc/mysql
WORKDIR /backups/mysql
SHELL ["/bin/bash", "-c"]
