@echo off
set JAVA_OPTS=-DenableRecordCounters=true -Dnme.parallel.strategy=none -Xmx512m -XX:MaxPermSize=128m 

REM other valuable runtime parameters 
REM -Dnme.taskExecutor.debug=true

set INSTANCE_ID=%RANDOM%

if not exist ..\etc\elasticsearch.yml (
	goto create_default_elastic
) else (
	goto check_mda
)

:create_default_elastic
setlocal enabledelayedexpansion
set INTEXTFILE=..\etc\elasticsearch.yml-sample
set OUTTEXTFILE=..\etc\elasticsearch.yml
set SEARCHTEXT=mdm_cluster_replace_me
set REPLACETEXT=mdm-%COMPUTERNAME%-%USERNAME%-%INSTANCE_ID%
set OUTPUTLINE=

for /f "tokens=1,* delims=¶" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A
SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

echo !modified! >> %OUTTEXTFILE%
)

:check_mda
if not exist ..\etc\mda-config.xml (
	goto create_default_mda
) else (
	goto start
)

:create_default_mda
setlocal enabledelayedexpansion
set INTEXTFILE=..\etc\mda-config.xml-sample
set OUTTEXTFILE=..\etc\mda-config.xml
set SEARCHTEXT=mdm_cluster_replace_me
set REPLACETEXT=mdm-%COMPUTERNAME%-%USERNAME%-%INSTANCE_ID%
set OUTPUTLINE=

setlocal DisableDelayedExpansion
for /f "tokens=1,* delims=¶" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A

setlocal EnableDelayedExpansion
SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

echo !modified! >> %OUTTEXTFILE%
endlocal
)
goto start

:start
call "%DQC_HOME%\bin\onlinectl.bat" -config ..\etc\mdm.serverConfig start
if not errorlevel 1 goto done
pause "Server startup failed. Press any key when ready"
:done
