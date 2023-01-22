FROM node:16-alpine
USER root
ENV NODE_ENV production

RUN apk update && apk add --update nginx git openrc curl && rm -rf /var/cache/apk/*

COPY ./init.sh /home/root/init.sh
RUN chmod 544 /home/root/init.sh
COPY default.conf /etc/nginx/http.d/default.conf

RUN git clone https://github.com/benc-uk/nodejs-demoapp.git /app && cd /app
RUN npm install --production --silent --prefix /app/src

WORKDIR /app/src

EXPOSE 80
CMD ["/home/root/init.sh"]
