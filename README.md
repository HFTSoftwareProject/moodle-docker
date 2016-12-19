hftstuttgart/moodle-docker
==========================

This Docker image provides the LAMP stack, installs Moodle 3.1 and the [MoJEC moodle plugin for JUnit Test Assignments] with External MySQL (https://github.com/HFTSoftwareProject/moodle-assignsubmission_mojec)

It is a fork from https://github.com/jmhardison/docker-moodle

to build image : docker build -t hftstuttgart/moodle .

to run :

docker run -d --name DB -p 3306:3306 -e MYSQL_DATABASE=moodle -e MYSQL_ROOT_PASSWORD=moodle -e MYSQL_USER=moodle -e MYSQL_PASSWORD=moodle mysql

docker run -d -P --name moodle --link DB:DB -e MOODLE_URL=http://10.40.10.5:80 -p 80:80 hftstuttgart/moodle
