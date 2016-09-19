@echo off

set CATALINA_HOME=%DQC_HOME%\..\tomcat
set INITIAL_CLASSPATH="%DQC_HOME%\lib\derby.jar;%DQC_HOME%\lib\derbyclient.jar;%DQC_HOME%\lib\derbytools.jar;%DQC_HOME%\lib\derbynet.jar"

call "%DQC_HOME%\bin\run_java.bat" org.apache.derby.iapi.tools.run server shutdown
