FROM tomcat:7.0.90-jre7-alpine
ENV spring.profiles.active=dev 
ENV CATALINA_OPTS=" -Dlogback.ContextSelector=JNDI"
ADD builds/lib/ILCH-*.war $CATALINA_HOME/webapps/ilch.war
EXPOSE 8080
#CMD catalina.sh run

# docker run -p 8080:8080 -it 1d91ebffd6d3 /bin/sh