############################################
# base build image
#FROM node:lts-alpine as build-stage

# Create app directory
#WORKDIR /app

# Copy both 'package.json' and 'package-lock.json' (if available)
#COPY frontend/package*.json ./

# Install project dependencies
#RUN npm install

# Bundle app source
#COPY frontend/. .

# Build app for production with minification
#RUN npm run build

#EXPOSE 8080
#############################################
#FROM nginx:1.14.1-alpine as production-stage

#COPY --from=build-stage app/target/dist /usr/share/nginx/html

#EXPOSE 80"""

#CMD [ "/bin/bash", "-c", "sudo nginx -g 'daemon off;'" ]

###########################################

FROM node:8

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY frontend/package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY frontend/. .

EXPOSE 8080

CMD [ "node", "server.js" ]
