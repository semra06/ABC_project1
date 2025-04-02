# Tomcat 9 kullanarak bir base image oluştur
FROM tomcat:9.0-jdk11

# Tomcat'in webapps dizinine .war dosyasını kopyala
COPY target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/ABCtechnologies.war

# Tomcat 8080 portunda çalışıyor
EXPOSE 8080

# Tomcat başlat
CMD ["catalina.sh", "run"]
