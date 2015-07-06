FROM ubuntu:trusty

MAINTAINER Sandro Salles sandro@snippet.com.br

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y openssh-server python-setuptools docker.io && /usr/bin/easy_install supervisor

ADD supervisord.conf /etc/supervisord.conf

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.4.0

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

COPY . /app/
WORKDIR /app/

ENV AUTHORIZED_KEYS **None**
ENV DOCKER_HOST unix:///tmp/docker.sock

RUN chmod +x /app/*.sh

EXPOSE 22
CMD ["/app/run.sh"]


/tmp/docker.sock

/var/run/docker.sock