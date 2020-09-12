@echo off

setlocal EnableDelayedExpansion

set BUCK_HOME=%~dp0

set JAVA_HOME=%BUCK_HOME%jre

%BUCK_HOME%python3\python.exe %BUCK_HOME%bin\buck %*
