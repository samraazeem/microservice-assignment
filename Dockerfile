FROM tomcat:8.5-alpine
ADD target/*.war /usr/local/tomcat/webapps/
EXPOSE 8085
#CMD [ "catalina.sh", "run", "docker run -p 80:8085 SpringMVCWebApp" ] 
CMD [ "catalina.sh", "run"]