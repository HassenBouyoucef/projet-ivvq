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

<<<<<<< HEAD
EXPOSE 4200

CMD [ "node", "server.js" ]

=======
EXPOSE 8080

CMD [ "node", "server.js" ]
>>>>>>> 622f30b264a5615e05bf9caabee0b6f51f63d63f
