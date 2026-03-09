# Step 1: Use an official Node.js image as a base
FROM node:16

# Step 2: Create a non-root user and group, and set the user
RUN groupadd -g 1001 appuser && useradd -u 1001 -g appuser -m appuser

# Step 3: Set the working directory
WORKDIR /app

# Step 4: Copy package.json and package-lock.json (if present)
COPY package*.json ./

# Step 5: Install dependencies
RUN npm install

# Step 6: Install PM2 globally
RUN npm install pm2 -g

# Step 7: Create the .npm directory manually
RUN mkdir -p /app/.npm

# Step 8: Change ownership of /app, .npm, and other directories
RUN chown -R appuser:appuser /app /root/.npm /home/appuser /app/.npm

# Step 9: Set the user to appuser
USER appuser

# Step 10: Copy the rest of the application files
COPY . .

# Step 11: Expose the application port
EXPOSE 8080

# Step 12: Start the application using PM2
CMD ["pm2-runtime", "start", "server.js"]
