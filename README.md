# sshd-proxy

##### This is a container inspired by:
- **[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)**
- **[sullof/docker-sshd](https://github.com/sullof/docker-sshd)**
- **[tutum/authorizedkeys](https://github.com/tutumcloud/authorizedkeys/)**

Basically it acts like an ssh proxy/gateway, allowing you to execute bash commands into any container by mapping a ssh-key -- *[see Usage](#usage)* -- to the destination container.

There's no need to have OpenSSH installed at the destination since I'm using `docker exec -it $containeridOrName bash` to access the bash.

There's also no need to link the containers to this image, thanks to docker-gen.


### Usage

To run it:

    $ docker run -d -p 22:2222 -v /var/run/docker.sock:/tmp/docker.sock sandrosalles/sshd-proxy

Then start any containers you want proxied with an Env var `SSHD_PROXY_KEY=ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRVEH+lW4+H5Tfaa26 ...`

    $ docker run -e SSHD_PROXY_KEY=ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRVEH+lW4+H5Tfaa26 ...

If you want to have ssh access to the ssh-proxy container itself you can pass an Env var `AUTHORIZED_KEYS=<your-ow-keys-delimited-by-comma> ...`

    $ docker run -d -p 22:2222 -v /var/run/docker.sock:/tmp/docker.sock sandrosalles/sshd-proxy -e AUTHORIZED_KEYS=ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRVEH+lW4+H5Tfaa26 ...,ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0Kt3iWRdfsfsdfsVEH+lW6876fsdfasd76fa ...


### SFTP

As mentioned before, as this container does not depend on or use OpenSSH to access the proxied containers you won't be able to use it to SFTP into them ([nor should you](https://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/)).



### Usage on Tutum.co

Things to remember when using this container on Tutum.co:

1. Add an entry to the volumes section matching `/var/run/docker.sock:/tmp/docker.sock`
2. Run this container in **privileged mode** as it uses docker internally to bash into the proxied containers
3. Give it **Full access** on Environment variables/API Roles
