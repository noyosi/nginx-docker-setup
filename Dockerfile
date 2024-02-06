# Use Alpine Linux as the base image
FROM alpine:latest


# using package manager
# The simplest option is to use the package manager, although it offers less control over the installation process
# RUN apk --no-cache add nginx


# Install dependencies required for compiling NGINX and for wget
RUN apk add --no-cache build-base wget zlib-dev pcre-dev openssl-dev

# Download and unpack NGINX from the nginx website
RUN wget -O nginx.tar.gz https://nginx.org/download/nginx-1.24.0.tar.gz && \
    tar zxvf nginx.tar.gz && \
    cd nginx-* && \
    ./configure && \
    make && \
    make install


# Expose port 80 for the web server
EXPOSE 80

# Start NGINX in the foreground instead of as a service, so there will be a main process
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
