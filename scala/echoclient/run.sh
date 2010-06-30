#JAVA_HOME=
export MAVEN2_REPO=$HOME/.m2/repository
$JAVA_HOME/bin/java -Dfile.encoding=UTF-8 -server -jar $MAVEN2_REPO/org/tigris/pomstrap/pomstrap/1.0.14/pomstrap-1.0.14.jar com.treegger.app:echo-client:0.1 com.treegger.app.echo.EchoClient:launch
