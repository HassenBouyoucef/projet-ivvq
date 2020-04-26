############################################
# base build image
FROM node:lts-alpine as build-stage

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
#############################################
FROM nginx:1.14.1-alpine as production-stage

COPY --from=build-stage app/target/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
