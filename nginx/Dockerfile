FROM nginx:1.27-alpine
RUN apk add nano && \
    rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d