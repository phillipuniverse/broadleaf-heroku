This is an example of the Broadleaf frontend running on Heroku.  The original commit was derived by building from the archetype with the mvn archetype:generate command from CLI on OSX:

    ~/broadleaf/heroku » mvn archetype:generate -DarchetypeGroupId=org.broadleafcommerce -DarchetypeArtifactId=ecommerce-archetype -DarchetypeVersion=1.6.0-SNAPSHOT
    
Then various configurations were added on top to make it play nicely with Heroku. This runs an actual instance of Tomcat which you can see with the following maven plugin in site-war/pom.xml:

    <plugins>
        <plugin>
            <groupId>org.codehaus.cargo</groupId>
            <artifactId>cargo-maven2-plugin</artifactId>
            <configuration>
                <container>
                    <containerId>tomcat6x</containerId>
                    <zipUrlInstaller>
                        <url>http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.18/bin/apache-tomcat-6.0.18.zip</url>
                    </zipUrlInstaller>
                    <dependencies>
                        <dependency>
                            <groupId>javax.activation</groupId>
                            <artifactId>activation</artifactId>
                        </dependency>
                        <dependency>
                            <groupId>javax.mail</groupId>
                            <artifactId>mail</artifactId>
                        </dependency>
                    </dependencies>
                </container>
                <configuration>
                    <type>standalone</type>
                    <deployables>
                        <deployable>
                            <groupId>com.phillip</groupId>
                            <artifactId>site-war</artifactId>
                            <type>war</type>
                            <properties>
                                <context>ROOT</context>
                            </properties>
                        </deployable>
                    </deployables>
                </configuration>
            </configuration>
            <executions>
                <execution>
                    <phase>package</phase>
                    <goals>
                        <goal>install</goal>
                        <goal>configure</goal>
                        <goal>deploy</goal>
                        <goal>package</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>

The admin application was also stripped out from the archetype because of the slug size limit for Heroku applications. Both the site and admin applications are ~60MB and Heroku limits you to 100MB total.

Running Locally
===============
Edit startup-foreman-local.sh and provide values that are relevant to your local instance of Postgres and the port Tomcat should run on. The app can then be launched with:
    
    ~/broadleaf/heroku » foreman start --procfile=Procfile-local

Assuming the default Tomcat port is left as-is, you should then be able to hit http://localhost:8080 to load the application

[Running instance on Heroku free](http://broadleaf.heroku.com). The app might need to refresh itself, so just give it a while to load on first-visit.

Blog post detailing these steps to come!