FROM tomcat:7.0.90-jre7-alpine
ENV spring.profiles.active=dev 
ENV CATALINA_OPTS=" -Dlogback.ContextSelector=JNDI"

#ADD builds/lib/ILCH-*.war $CATALINA_HOME/webapps/ilch.war
ADD heroku/catalina.sh /usr/local/tomcat/bin
RUN `chmod 777 /usr/local/tomcat/bin/catalina.sh`
#ENTRYPOINT ["/usr/local/start.sh"]
#CMD ["sed -i -e \"s/8080/$PORT/\" /usr/local/tomcat/conf/server.xml","catalina.sh", "run"]