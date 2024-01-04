FROM node:16-alpine

ENV NODE_ENV=dev
ENV NODE_ENV=prod

# update packages
RUN apk update

# create root application folder
WORKDIR /app

# copy configs to /app folder
COPY package*.json ./
COPY tsconfig*.json ./


RUN npm install 

RUN npm i -g dotenv

COPY . .

RUN npm run build

EXPOSE 8080


CMD ["sh", "-c", "npm run typeorm:migrate && npm run start"]

# Base image for development
# FROM node:16 as development 

# ENV NODE_ENV=dev

# # Set the working directory in the container
# WORKDIR /usr/src/app

# # Copy package.json and package-lock.json
# COPY package*.json ./ 

# # Install dependencies including 'devDependencies'
# RUN npm ci --development

# # Copy TypeScript configuration and source code
# COPY tsconfig*.json ./ 
# COPY . .

# # Build the application
# RUN npm run build










# # Base image for production
# FROM node:16 as production 

# ENV NODE_ENV=prod

# # Set the working directory in the container
# WORKDIR /app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install only production dependencies
# RUN npm ci --only=production 

# # Copy TypeScript configuration and source code
# COPY tsconfig*.json ./ 



# # Copy the built application from the development stage
# COPY --from=development /usr/src/app/.keys ./.keys
# COPY --from=development /usr/src/app/dist ./dist 
# COPY --from=development /usr/src/app/src/environment/.env.prod ./ 

# # Expose the port the app runs on
# EXPOSE 8080




# # Run migrations and then start the application
# CMD ["sh", "-c", "npm run typeorm:migrate && npm run start"]
