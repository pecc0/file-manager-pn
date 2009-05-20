#!/bin/bash
#echo $(dirname $0)
cd $(dirname $0)/../src
#echo $(pwd)
mxmlc -output ../../../server/www/secure/accountHandler.swf accountHandler.mxml
mxmlc +configname=air -output ../bin/accountHandler.exe accountHandler.mxml