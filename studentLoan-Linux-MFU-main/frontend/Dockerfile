# Use Node.js as the base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Define an environment variable for the port
#ARG VUE_APP_API_PORT=1080
#ENV VUE_APP_API_PORT=${VUE_APP_API_PORT}

# Expose the port (Docker level)
#EXPOSE ${VUE_APP_API_PORT}

# Start the application
#CMD ["npm", "run", "serve"]
