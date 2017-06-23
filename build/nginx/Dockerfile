FROM alpine:3.6

# Install nginx
RUN apk add --update nginx certbot tzdata openssl && \
    rm -rf /var/cache/apk/*

# Copy proper config
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/service.conf /etc/nginx/service.conf

ADD script/entrypoint.sh /entrypoint.sh
ADD script/le.sh /le.sh

RUN \
 mkdir -p /usr/share/nginx/html && \
 rm /etc/nginx/conf.d/default.conf && \
 chmod +x /entrypoint.sh && \
 chmod +x /le.sh

# Starting nginx in foreground mode
CMD ["/entrypoint.sh"]

# Expose the ports for nginx
EXPOSE 80 443
