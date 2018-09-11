FROM tomcat:7.0.90-jre7-alpine
#FROM andreptb/tomcat:7-jdk7
ENV spring.profiles.active=dev 
ENV CATALINA_OPTS=" -Dlogback.ContextSelector=JNDI"
ADD builds/lib/ILCH-*.war $CATALINA_HOME/webapps/ilch.war
EXPOSE 8080
EXPOSE 3306
#RUN chmod 777 /usr/local/tomcat/logs
#CMD catalina.sh run

# docker run -p 8080:8080 -it 1d91ebffd6d3 /bin/sh