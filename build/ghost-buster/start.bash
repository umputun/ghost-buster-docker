#!/bin/bash

GHOST="/ghost"
OVERRIDE="/ghost-override"

CONFIG="config.production.json"
DATA="content/data"
IMAGES="content/images"
THEMES="content/themes"

cd "$GHOST"

# Symlink data directory
if [ ! -d "$OVERRIDE/$DATA" ]; then
  mkdir -p "$OVERRIDE/$DATA"
  for file in $DATA/*; do
    cp -r "$file" "$OVERRIDE/$DATA"
  done
fi

rm -fr "$DATA"
ln -sfn "$OVERRIDE/$DATA" "$DATA"

# Symlink images directory
mkdir -p "$OVERRIDE/$IMAGES"
rm -fr "$IMAGES"
ln -s "$OVERRIDE/$IMAGES" "$IMAGES"

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi

# Symlink themes.
if [[ -d "$OVERRIDE/$THEMES" ]]; then
  for theme in $(find "$OVERRIDE/$THEMES" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
  do
    rm -fr "$THEMES/$theme"
    ln -s "$OVERRIDE/$THEMES/$theme" "$THEMES/$theme"
  done
fi

sed -i -e "s|${DEFAULT_BLOG_DOMAIN}|${BLOG_DOMAIN}|g" $GHOST/$CONFIG

#start background watcher for buster
touch /ghost/content/data/ghost.db
while inotifywait -e modify /ghost/content/data/ghost.db; do sleep 10 && /ghost/publish.sh; done &

# Start Ghost
chown -R ghost:ghost /data /ghost /ghost-override
su ghost << EOF
cd "$GHOST"
ghost run
EOF

