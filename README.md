# perconaxtrabackup

Docker container to backup mariadb instance using mariabackup.<br/>
Largery based on https://github.com/khoanguyen96/dockerfiles/tree/master/percona-xtrabackup <br/>
<br/>
To backup: <br/>
```
#!/bin/bash

docker run --rm \
       --net webgateway \
       -v /srv/nextcloud/mariadb:/var/lib/mysql \
       -v /srv/mysqlbackup/backup.cnf:/etc/mysql/backup.cnf \
       -v /srv/mysqlbackup/encryption_key:/backups/mysql/encryption_key \
       -v /srv/mysqlbackup/backup:/backups/mysql \
cardonaje/perconaxtrabackup:latest \
    backup-mysql.sh
```

To extract backup: <br/>
```
#!/bin/bash

docker run --rm \
       -e DAY="Mon" \
       --net webgateway \
       -v /srv/nextcloud/mariadb:/var/lib/mysql \
       -v /srv/mysqlbackup/backup.cnf:/etc/mysql/backup.cnf \
       -v /srv/mysqlbackup/encryption_key:/backups/mysql/encryption_key \
       -v /srv/mysqlbackup/backup:/backups/mysql \
cardonaje/perconaxtrabackup:latest \
    extract-mysql.sh full-12-17-2018_14-29-22.xbstream
```
To prepare backup:<br/>
```
#!/bin/bash

docker run --rm \
       -e DAY="Mon" \
       --net webgateway \
       -v /srv/nextcloud/mariadb:/var/lib/mysql \
       -v /srv/mysqlbackup/backup.cnf:/etc/mysql/backup.cnf \
       -v /srv/mysqlbackup/encryption_key:/backups/mysql/encryption_key \
       -v /srv/mysqlbackup/backup:/backups/mysql \
cardonaje/perconaxtrabackup:latest \
    prepare-mysql.sh
```
