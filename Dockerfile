# ------------------------
# Build stage
# ------------------------
FROM node:20-bullseye-slim AS builder

WORKDIR /usr/src/app

# Copy package files and install all dependencies
COPY package*.json ./
RUN npm install

# Copy all source code and build
COPY . .
RUN npm run build

# ------------------------
# Production stage
# ------------------------
FROM node:20-bullseye-slim

WORKDIR /usr/src/app

# Copy only package files and install production dependencies
COPY package*.json ./
RUN npm install --production

# Copy built output from builder
COPY --from=builder /usr/src/app/dist ./dist

# Expose port
EXPOSE 8080

# Start the app
CMD ["node", "dist/main.js"]
