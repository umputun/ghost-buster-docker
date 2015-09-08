#!/bin/sh
echo "building static site"
buster generate
echo "export md"
ghost-export /ghost /export.md

echo "publishing ..."
#copy from  static/* to external desitnation

