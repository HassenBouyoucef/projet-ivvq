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
