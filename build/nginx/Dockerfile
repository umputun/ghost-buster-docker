FROM alpine:3.4

# Install nginx
RUN apk add --update nginx && \
	rm -rf /var/cache/apk/*

# Copy proper config
COPY nginx.conf /etc/nginx/nginx.conf

# Starting nginx in foreground mode
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

# Expose the ports for nginx
EXPOSE 80

#todo:
#  add 443 port
#  add let's encrypt certificate and tool https://github.com/xenolf/lego