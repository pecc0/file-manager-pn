#!/bin/bash
#echo $(dirname $0)
cd $(dirname $0)/../src
#echo $(pwd)
if [ _$1==_ ]; then
	for i in *.mxml; do
		echo compiling $i
		mxmlc -output ../../../server/www/secure/flex/${i%%.*}.swf $i

	done
	
else
	echo compiling $1
	mxmlc -output ../../../server/www/secure/flex/${1%%.*}.swf $1
fi
#mxmlc -output ../../../server/www/secure/accountHandler.swf accountHandler.mxml
#mxmlc +configname=air -output ../bin/accountHandler.exe accountHandler.mxml