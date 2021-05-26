@echo off
pushd ..\
call Tools\premake5.exe vs2019
popd
PAUSE