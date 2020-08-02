@echo off

setlocal EnableDelayedExpansion

set BUCK_HOME=%~dp0

set JAVA_HOME=%BUCK_HOME%jre

set PATH=%BUCK_HOME%python2;%PATH%

python %BUCK_HOME%bin\buck %* 
