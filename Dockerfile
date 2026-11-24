# Shamchester United · imagen de producción (Portainer / docker compose)
# 1) Compila el WAR con Maven
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY pom.xml .
RUN mvn -B -q dependency:go-offline
COPY src ./src
RUN mvn -B -q package -DskipTests

# 2) Tomcat 10.1 (Jakarta EE 10, como Struts 7 y Spring 6) solo con el WAR
FROM tomcat:10.1-jre21
RUN rm -rf /usr/local/tomcat/webapps/* /usr/local/tomcat/webapps.dist
COPY --from=build /src/target/shamchester.war /usr/local/tomcat/webapps/ROOT.war

ENV LOG_DIR=/logs \
    TZ=Europe/Madrid \
    JAVA_OPTS="-XX:MaxRAMPercentage=75 -Djava.security.egd=file:/dev/urandom"

EXPOSE 8080
CMD ["catalina.sh", "run"]
