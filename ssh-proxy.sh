#!/bin/bash

if [ "$SSH_ORIGINAL_COMMAND" = "" ] 
then
  export DOCKER_HOST=unix:///tmp/docker.sock && docker exec -it $1 script -q -c "/bin/bash/" /dev/null
else
  export DOCKER_HOST=unix:///tmp/docker.sock && docker exec -i $1 script -q -c "$SSH_ORIGINAL_COMMAND && exit $?" /dev/null &
fi