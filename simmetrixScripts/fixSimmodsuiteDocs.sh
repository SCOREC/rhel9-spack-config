#!/bin/bash -ex
cd $1
for directory in `ls`; do 
  if [ -d $directory ]; then
    echo $directory
    perl -pi -e "s/href=\"index.html\"\>Main\&nbsp\;Page/href=\"http:\/\/www.scorec.rpi.edu\/~cwsmith\/SCOREC\/SimModSuite_latest\/$directory\"\>Main\&nbsp\;Page/g" $directory/*.html
    perl -pi -e "s/href=\"..\/index.html\"\>Simulation Modeling Suite 8.0/href=\"http:\/\/www.scorec.rpi.edu\/~cwsmith\/SCOREC\/SimModSuite_latest\">Simulation Modeling Suite 8.0/g" $directory/*.html
  fi
done
cd -

