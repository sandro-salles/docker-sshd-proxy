# sshd-proxy

This is a container inspired by **[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)** and **[sullof/docker-sshd](https://github.com/sullof/docker-sshd)** that acts like a ssh proxy/gateway, allowing you to execute bash commands into any container by mapping a ssh-key -- *see DEPLOYMENT_KEY* -- to the destination container.

There's no need to have OpenSSH installed at the destination since I'm using `docker exec -it $containeridOrName bash` to access the bash.

There's also no need to link the containers to this image, thanks to docker-gen.
