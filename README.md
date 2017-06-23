# ghost-buster-docker
Ready to use ghost with buster and auto-generation in docker container with integrated Let's Encrypt support.

* [Ghost](https://ghost.org) is a simple, powerful publishing platform that allows you to share your stories with the world.
* [Buster](https://github.com/axitkhurana/buster) is a brute force static site generator for Ghost.
* [Let's Encrypt](https://letsencrypt.org/) is a free, automated, and open Certificate Authority. 

All of this in two ready to use containers with ability to create backups automatically, save md files and (optionally) publish static blogs to external places, like S3.

### How to use:

1. pull repo from github: `git clone https://github.com/umputun/ghost-buster-docker.git`
1. make sure you have [docker-compose](https://docs.docker.com/compose/install/) installed
1. edit `.env` file with your own domain, email (for LetsEncrypt) and timezone
1. pull image with `docker-compose pull`
1. if you don't want pre-built image, make you own. `docker-compose build` will do it
1. start it with `docker-compose up -d`
1. go to `https://your.domain/ghost`

### What will it do?

1. run ghost on port 2368
1. `nginx/script/entrypoint.sh` requests LE certificate and will refresh every 60 days.
1. `nginx/script/le.sh` gets SSL
1. run nginx proxy on ports 80 and 443
1. watch for changes and generate static content in `static`
1. nginx will proxy all request to this `static`, except request to /ghost (admin interface)


_Automated build on docker-hub: [umputun/ghost-buster-docker](https://hub.docker.com/r/umputun/ghost-buster-docker/)_
