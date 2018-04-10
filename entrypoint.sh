#!/bin/bash

function purge() {
  echo "Starting Purge"

  if [ "$BUCKETS" == "" ]; then
    echo "BUCKETS is empty"
    TAB=$(mc --json ls $SRC | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | cut -d / -f1 | tr " " "\n")
  else
    echo "BUCKETS is not empty"
    TAB=($(echo $BUCKETS | tr ',' "\n"))
  fi

  for BUCKET in "${TAB[@]}"
  do
    echo $BUCKET
    mc rm --recursive --dangerous --fake --force --older-than=$RETENTION $SRC/$BUCKET/
  done

  echo "Purge Done"

  exit 0
}

sleep 10
purge
