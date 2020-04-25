# base build image
FROM maven:3-jdk-8 as maven

WORKDIR /app

# Copy the project object model file
COPY backend/pom.xml ./pom.xml

# fetch all dependencies
RUN mvn dependency:go-offline -B

# copy your other files
COPY backend/src ./src

# build for release
# NOTE : "date-format-java-" must be placed with the proper prefix
RUN mvn package && cp target/yaqari-0.0.1-SNAPSHOT.jar app.jar

############################################
#smaller, final base image
FROM openjdk:8-jre-alpine

# set deployment directory
WORKDIR /app

# copy over the built artifact fropm maven image
COPY --from=maven /app/app.jar ./app.jar
EXPOSE 8080

# set the startup command to run your library
# See https://discuss.pivotal.io/hc/en-us/articles/230141007
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/.urandom", "-jar", "./app.jar"]
