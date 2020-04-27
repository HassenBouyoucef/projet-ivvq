############################################
# base build image
FROM node:lts-alpine as node

# Create app directory
WORKDIR /app

# Copy both 'package.json' and 'package-lock.json' (if available)
COPY frontend/package*.json ./

# Install project dependencies
RUN npm install

# Bundle app source
COPY frontend/. .

# Build app for production with minification
RUN npm run build

EXPOSE 8080

#CMD [ "node", "server.js" ]
############################################
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
RUN mvn package && cp target/yaqari-*.jar app.jar

############################################
#smaller, final base image
FROM openjdk:8-jre-alpine

# set deployment directory
WORKDIR /app

# copy over the built artifact from maven image
COPY --from=maven /app/app.jar ./app.jar

COPY --from=node /app/dist ./app/src/main/resources

EXPOSE 8080

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/.urandom", "-jar", "./app.jar"]