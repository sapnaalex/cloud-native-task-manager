# Stage 1: Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package management files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code and build config
COPY . .

# Compile TypeScript to JavaScript
RUN npm run build

# Stage 2: Production runtime stage
FROM node:18-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# Copy package management files and install production-only dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy compiled JavaScript from builder stage
COPY --from=builder /app/dist ./dist

# Expose server port
EXPOSE 3000

# Start the application
CMD ["node", "dist/index.js"]