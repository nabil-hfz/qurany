FROM node:16-alpine

# ENV NODE_ENV=dev
ENV NODE_ENV=prod

# update packages
RUN apk update

# create root application folder
WORKDIR /app

# copy configs to /app folder
COPY package*.json ./
COPY tsconfig.json ./
# copy source code to /app/src folder
# COPY src /app/src
# COPY dist /app/dist
COPY . .
# check files list
RUN ls -a

RUN npm install --all
# RUN npm run build

# EXPOSE 8080

CMD [ "npm", "run" , "start" ]
