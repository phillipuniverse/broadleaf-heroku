#point to the correct configuration and webapp
CATALINA_BASE=`pwd`/site-war/target/cargo/configurations/tomcat6x
export CATALINA_BASE

#copy over the Heroku config files
cp ./site-war/heroku-server.xml ./site-war/target/cargo/configurations/tomcat6x/conf/server.xml

#make the Tomcat scripts executable
chmod a+x ./site-war/target/cargo/installs/apache-tomcat-6.0.18/apache-tomcat-6.0.18/bin/*.sh

#set the correct port and database settings
JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=256M -Xmx512M -Dhttp.port=$PORT -DDATABASE_URL=$DATABASE_URL"
export JAVA_OPTS

#start Tomcat
./site-war/target/cargo/installs/apache-tomcat-6.0.18/apache-tomcat-6.0.18/bin/catalina.sh run