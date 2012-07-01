#!/bin/sh

if [ ! -d ./jars ]; then

  echo "Downloading jars"
  mkdir -p ./jars
  cd ./jars

  wget  http://mirrors.gigenet.com/apache//xerces/j/binaries/Xerces-J-bin.2.11.0.tar.gz\
        http://apache.osuosl.org/incubator/odftoolkit/binaries/odftoolkit-0.5-incubating-bin.tar.gz

  for targz in *.tar.gz; do
    echo "Extracting $targz"
    tar zxf $targz 
  done

  cd ..
fi

JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
export JAVA_HOME=$JAVA_HOME; echo "set JAVA_HOME to $JAVA_HOME"

basedir=$(readlink -f ./jars)

CLASSPATH=$basedir/xerces-2_11_0/xercesImpl.jar:$basedir/xerces-2_11_0/xml-apis.jar:$basedir/odftoolkit-0.5-incubating/simple-odf-0.7-incubating.jar:$basedir/odftoolkit-0.5-incubating/odfdom-java-0.8.8-incubating.jar
export CLASSPATH=$CLASSPATH; echo "set CLASSPATH to $CLASSPATH"
