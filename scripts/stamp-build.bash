#!/bin/bash

set -o errexit
set -o pipefail

if [ -z "$GITHUB_SHA" ]
then
   b=`git rev-parse --abbrev-ref HEAD`
   v=`git rev-parse --short HEAD`
   version="$b+sha.$v"
else
   v=`echo $GITHUB_SHA | cut -c1-8`
   version="#$v"
fi

## replease _BUILD_HASH_ with the current build number
perl -i -pe "s/_BUILD_HASH_/$version/g" dist/html/*.js

status=$?
if [ $status -eq 0 ];then
   echo ">> Build was stamped: $version"
else
   echo ">> Could not stamp this build!"
fi
