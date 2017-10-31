FROM alpine:3.6

RUN \
#major part
  apk --update --no-progress add nodejs-lts nodejs-npm \
#system utility
  unrar bash unzip inotify-tools curl wget sudo \
#python and other stuff
  py-setuptools python-dev libxml2-dev libxslt-dev py-pip py-libxslt py-lxml

# Install Ghost
ENV GHOST_CLI_VERSION 1.1.3
ENV GHOST_VERSION 1.14.0
ENV GHOST_EXPORT_VERSION 2.0.0
ENV DEFAULT_BLOG_DOMAIN http://my-ghost-blog.com

RUN \
  adduser ghost -D -h /ghost -u 987
RUN \
  cd /ghost && \
  npm install -g ghost-cli@${GHOST_CLI_VERSION} && \
  ghost install \
    --no-start --no-stack \
    --version=${GHOST_VERSION} \
    --url=${DEFAULT_BLOG_DOMAIN} \
    --process=local --no-setup-nginx --no-setup-systemd \
    --db=sqlite3 --dbpath=./content/data/ghost.db && \
  /usr/lib/node_modules/ghost-cli/node_modules/.bin/yarn cache clean && \
  cd current && npm prune --production && cd .. && \
  npm cache clean --force

RUN \
  sed -i.bak 's/127.0.0.1/0.0.0.0/' /ghost/config.production.json

#install buster
RUN \
  pip install buster

#install md exporter
RUN \
  npm install -g ghost-export@${GHOST_EXPORT_VERSION} && \
  npm cache clean --force

ADD start.bash /ghost-start
ADD publish.sh /ghost/publish.sh
RUN chmod +x /ghost/publish.sh

VOLUME ["/data", "/ghost-override"]

WORKDIR /ghost

CMD ["bash", "/ghost-start"]

EXPOSE 2368
