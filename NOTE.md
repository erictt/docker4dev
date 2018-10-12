## SOME NOTES

### Remove all untagged images

`docker rmi $(docker images -f "dangling=true" -q)`

`docker rmi $(docker images | grep "^<none>" | awk "{print $3}")`

### Remove all stopped containers

`docker rm $( docker ps -q -f status=exited)`

### Stop/Remove all containers

`docker stop $(docker ps -a -q)`

`docker rm $(docker ps -a -q)`

### Remove `restart=always` conf from container

`docker update --restart=no container_id`

### How to clear docker container cache files

`docker-compose rm`

Don't forget to execute this command before every `docker-compose up` or `docker-compose run` if you are trying to get a brand new start.

### List all containers, include stoped ones

`docker ps -a`

### How to run a command

`docker-compose run mysql-cli -hdb -uroot -pmydev`

### How to connection to redis via command line

`docker-compose run redis redis-cli -h redis`

### Upload marvel license

`curl -XPUT -u admin 'http://localhost:9200/_license?acknowledge=true' -d @/path/to/license.json`

### Backup volumes

* refer to [Docker Volumes Office Document](https://docs.docker.com/engine/tutorials/dockervolumes/) and [Understand Docker Volume](http://container-solutions.com/understanding-volumes-docker/)

* backup action is based on containers, so
* you need to stop db contrainers, before execute this command, and please notice this:
* `mysqldb.tar` when this command finished, you can find the `mysqldb.tar` under current directory
* `/var/lib/mysql` is the data directory

* backup mysql volume

`docker run --rm -v mydev_mysql_data:/var/lib/mysql -v $(pwd):/backup debian:jessie tar cvf /backup/mysqldb.tar /var/lib/mysql`

* backup mongo volume

`docker run --rm -v mydev_mongo_data:/data/db  -v $(pwd):/backup debian:jessie tar cvf /backup/mongodb.tar /data/db`

* backup elasticsearch volume

`docker run --rm -v mydev_elasticsearch_data:/data/elasticsearch -v $(pwd):/backup debian:jessie tar cvf /backup/elasticsearch.tar /data/elasticsearch`

### Restore volumes

* as the backup action, before restoring, you need to start the container first.
* since we just want to restore the data, so recommend you start a new container to restore data, then remove it, or just add the --rm parameter when you start it.
* DON'T FORGET `--strip` to remove leading directories. for example, if compressed directory is `/var/lib/mysql`, then strip `3`.

* backup mysql volume

    * so first to create the volume if it's not there:

        `docker volume create --name mydev_mysql_data`

    * then start a new container with the volume:

        `docker run -it --rm --name restore_container --volume mydev_mysql_data:/var/lib/mysql debian:jessie /bin/bash` // since the volume already defined in the compose file

    * at the last, start to restore: (tar file is in the same directory)

        `docker run --rm --volumes-from restore_container -v $(pwd):/backup debian:jessie bash -c "cd /var/lib/mysql && tar xvf /backup/mysqldb.tar --strip 3"`
