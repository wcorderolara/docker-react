#BUILD PHASE
FROM node:12-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package.json ./

USER node

RUN npm install

COPY ./ ./

COPY --chown=node:node . .

RUN npm run build

# RUN PHASE
FROM nginx

COPY --from=0 /home/node/app/build /usr/share/nginx/html
