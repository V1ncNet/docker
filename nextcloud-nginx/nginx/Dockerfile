FROM nginx:alpine

LABEL maintainer="vincent.nadoll@gmail.com"

COPY nginx.conf.template  /etc/nginx/nginx.conf.template
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
