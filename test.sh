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

echo "Running test"

JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
echo "set JAVA_HOME to $JAVA_HOME"
CLASSPATH=./jars/xerces-2_11_0/xercesImpl.jar:./jars/xerces-2_11_0/xml-apis.jar:./jars/odftoolkit-0.5-incubating/simple-odf-0.7-incubating.jar:./jars/odftoolkit-0.5-incubating/odfdom-java-0.8.8-incubating.jar jruby lib/oclt.rb
