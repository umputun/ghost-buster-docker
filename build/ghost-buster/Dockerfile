FROM node:0.12

RUN \
  apt-get update && apt-get install unzip python-setuptools python-dev libxml2-dev libxslt-dev nginx -yq && \
  easy_install pip

# Install Ghost
RUN \
  cd /tmp && \
  wget https://ghost.org/zip/ghost-latest.zip && \
  unzip ghost-latest.zip -d /ghost && \
  rm -f ghost-latest.zip && \
  echo "unzip completed"

RUN \
  cd /ghost && \
  npm cache clean && \
  npm install --production -d

RUN \
  sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js && \
  useradd ghost --home /ghost

#install buster
RUN pip install buster

#install md exporter
RUN \
 cd / ghost && \
 npm install -g ghost-export


ADD start.bash /ghost-start
ADD publish.sh /ghost/publish.sh
RUN chmod +x /ghost/publish.sh

RUN apt-get install inotify-tools -y

ENV NODE_ENV production

VOLUME ["/data", "/ghost-override"]

WORKDIR /ghost

CMD ["bash", "/ghost-start"]

EXPOSE 2368
