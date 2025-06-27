## Using multi-stage builds to create the docker image

## Stage 1: Creating base image
FROM node:18-alpine AS builder

WORKDIR /usr/src/app

COPY package.json .

RUN npm install --production

## Stage 2: Creating final image

FROM node:18-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/node_modules ./node_modules

## Copying everything else
COPY ./src ./src

## Expose port
EXPOSE 3000

##Running node
CMD ["node", "src/app.js"]