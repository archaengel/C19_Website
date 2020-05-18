FROM node:10.13-alpine
ENV NODE_ENV production
WORKDIR /usr/src/app

# Declaring environment variables
ENV MONGO_DB_URL_DEV=$MONGO_DB_URL_DEV
ENV VOLUNTEER_PRIVATE_KEY=$VOLUNTEER_PRIVATE_KEY
ENV VOLUNTEER_PUBLIC_KEY=$VOLUNTEER_PUBLIC_KEY
ENV RESEARCHER_PRIVATE_KEY=$RESEARCHER_PRIVATE_KEY
ENV RESEARCHER_PUBLIC_KEY=$RESEARCHER_PUBLIC_KEY
ENV VERIFY_OPTIONS_EXPIRES_IN=$VERIFY_OPTIONS_EXPIRES_IN
ENV VERIFY_OPTIONS_ALGORITHM=$VERIFY_OPTIONS_ALGORITHM
ENV TEMP_PASSWORD_LENGTH=$TEMP_PASSWORD_LENGTH
ENV RDS_FILE=$RDS_FILE

#Copying over package.json and package-lock.json
COPY package*.json ./

#Installing all the dependencies
RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

#Copying over all the files
COPY . .
RUN wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem

#Exposing port 3000
EXPOSE 3000
#Running the command
CMD [ "node", "server.js" ]