#!/bin/bash

option="$1"

sudo docker rm $(sudo docker ps -a -q)

if [ "$option" = "build" ]
then
	docker build -t venantvr/rider .
fi

if [ "$option" = "run" ]
then
	# allow X11 access
	xhost +local:docker

	# start rider
	docker run -d \
	  -d \
	  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
	  -v ${PWD}:/developer/project \
	  -e DISPLAY=unix${DISPLAY} \
	  -e GDK_SCALE \
	  -e GDK_DPI_SCALE \
	  -p 5000:5000 \
	  --device /dev/snd \
	  --name venantvr-rider \
	  venantvr/rider 

	docker exec venantvr-rider /developer/bin/start-shell
fi
