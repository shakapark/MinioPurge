#!/bin/bash

function purge() {
  echo "Starting Purge"

  if [ "$BUCKETS" == "" ]; then
    echo "BUCKETS is empty"
    TAB=($(mc --json ls $SRC | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | tr "/ " "\n"))
  else
    echo "BUCKETS is not empty"
    TAB=($(echo $BUCKETS | tr ',' "\n"))
  fi

  for BUCKET in "${TAB[@]}"
  do
    echo $BUCKET
    FILES=$(mc --json ls $SRC/$BUCKET/)
# | grep -Eo '"key":.*?[^\\]",'))
#|awk -F':' '{print $2}' | cut -d \" -f2 | tr "/ " "\n"))
    for FILE in $FILES
    do
      FILE=($(echo $FILE  | grep -Eo '"key":.*?[^\\]",' | awk -F':' '{print $2}' | cut -d \" -f2 | tr "/ " "\n"))
      mc rm --recursive --fake --older-than=$RETENTION $SRC/$BUCKET/$FILE
    done
  done

  echo "Purge Done"

  exit 0
}

purge
