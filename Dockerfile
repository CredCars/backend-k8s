# Build stage
FROM node:20-bullseye-slim AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:20-bullseye-slim
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --only=production
COPY --from=builder /usr/src/app/dist ./dist
EXPOSE 8080
CMD ["node", "dist/main.js"]
