FROM node:10 AS ui-build
WORKDIR /usr/src/app
COPY client/ ./client/
RUN cdclient && npm install && npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/client/build ./client/build
COPY api/package*.json ./api/
RUN cd api && npm install
COPY api/index.js ./api/

EXPOSE 80

CMD ["node", "./api/index.js"]