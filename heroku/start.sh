echo $PORT 
echo $CATALINA_HOME 
echo $CATALINA_BASE
echo "-------------GOPI----------------"$PORT
sed -i -e "s/8080/$PORT/" /usr/local/tomcat/conf/server.xml
