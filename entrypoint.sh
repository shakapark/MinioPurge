#!/bin/bash

function purge() {
  echo "Starting Purge"

  if ["$BUCKETS" == ""]; then
    $TAB=$(mc --json ls $MINIO | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | cut -d / -f1 | tr " " "\n")
  else
    IFS=';' read -ra $TAB <<< "$BUCKETS"
  fi

#  for BUCKET in "${TAB[@]}"
#  do
#    mc rm --recursive --force --older-than=$RETENTION $MINIO/$BUCKET/*
#  done

  echo "Purge Done"

  exit 0
}

purge
