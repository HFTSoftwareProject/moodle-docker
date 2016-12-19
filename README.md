hftstuttgart/moodle-docker
==========================

This Docker image provides the LAMP stack, installs Moodle 3.1 and the [MoJEC moodle plugin for JUnit Test Assignments](https://github.com/HFTSoftwareProject/moodle-assignsubmission_mojec). An external MySQL database is required

It is a fork from [jmhardison/docker-moodle](https://github.com/jmhardison/docker-moodle)

The image can be build with `docker build -t hftstuttgart/moodle`

Run the MySQL database:
```
docker run -d --name DB -p 3306:3306 -e MYSQL_DATABASE=moodle -e MYSQL_ROOT_PASSWORD=moodle -e MYSQL_USER=moodle -e MYSQL_PASSWORD=moodle mysql
```

Run the Moodle container:
```
docker run -d -P --name moodle --link DB:DB -e MOODLE_URL=http://10.40.10.5:80 -p 80:80 hftstuttgart/moodle
```

Prebuild images can be found on [Docker Hub](https://hub.docker.com/r/hftstuttgart/moodle/)
