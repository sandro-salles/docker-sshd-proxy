# sshd-proxy

This is a container inspired by **[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)** and **[sullof/docker-sshd](https://github.com/sullof/docker-sshd)** that acts like a ssh proxy/gateway, allowing you to execute bash commands into any container by mapping a ssh-key -- *[see Usage](#usage)* -- to the destination container.

There's no need to have OpenSSH installed at the destination since I'm using `docker exec -it $containeridOrName bash` to access the bash.

There's also no need to link the containers to this image, thanks to docker-gen.


### Usage

To run it:

    $ docker run -d -p 22:2222 -v /var/run/docker.sock:/tmp/docker.sock sandrosalles/sshd-proxy

Then start any containers you want proxied with an env var `SSHD_PROXY_KEY=ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRVEH+lW4+H5Tfaa26 ...`

    $ docker run -e SSHD_PROXY_KEY=ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRVEH+lW4+H5Tfaa26 ...


If you want to have access to ssh-proxy container itself you can pass an env var `AUTHORIZED_KEYS=<your-ow-keys-delimited-by-\n> ...`

    $ docker run -d -p 22:2222 -v /var/run/docker.sock:/tmp/docker.sock sandrosalles/sshd-proxy -e AUTHORIZED_KEYS=ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRVEH+lW4+H5Tfaa26 ...\nssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRdfsfsdfsVEH+lW6876fsdfasd76fa ...