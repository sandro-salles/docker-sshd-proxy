#!/bin/bash

if [[ -t "$fd" || -p /dev/stdin ]]
then
  export DOCKER_HOST=unix:///tmp/docker.sock && docker exec -it $1 bash && exit $?
else
  export DOCKER_HOST=unix:///tmp/docker.sock && docker exec -i $1 script -q -c "$SSH_ORIGINAL_COMMAND && exit $?"
fi