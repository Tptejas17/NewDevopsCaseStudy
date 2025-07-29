# Use official Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy dependency files and install
COPY src/package*.json ./
RUN npm install

# Copy the rest of the app source code
COPY src/ .

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
