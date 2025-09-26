# use lts alpine base image (smaller)
FROM node:22.20.0-alpine AS base


# stage  for installing all dependencies
FROM base AS deps
WORKDIR /app
COPY package*.json .
RUN npm install && npm cache clean --force


# stage for building the app
FROM base AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# stage  for installing prod dependencies
FROM base AS prod-deps
WORKDIR /app
COPY package*.json .
RUN npm install --omit=dev && npm cache clean --force

# stage for running the app
FROM base 
WORKDIR /app
ENV NODE_ENV=production
COPY --from=prod-deps /app/node_modules ./node_modules
COPY package*.json .
COPY --from=build /app/.next ./.next

EXPOSE 3000
CMD ["npm","start"]
