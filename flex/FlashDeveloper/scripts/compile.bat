pushd %~dp0\..\src
mxmlc -output ..\..\..\server\www\secure\accountHandler.swf accountHandler.mxml
call amxmlc -output ..\bin\accountHandler.swf accountHandler.mxml
popd
