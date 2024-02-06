.PHONY: build run-nginx remove-container add-nginx-endpoint check

CONTAINER_NAME = my-nginx-container
NGINX_PORT = 8080
IMG_TAG = my-nginx-image

DOCKER_INSTALLED := $(shell command -v docker 2> /dev/null)

# Check if Docker is installed
ifndef DOCKER_INSTALLED
$(error Docker is not installed. Please install Docker before running this command.)
endif

build:
	docker build -t $(IMG_TAG) .


run-nginx:
# in case the container is running do nothing, in case the container is stopped: start it, and in case the container doesn't exists create and run it.
	@if [ -z "$$(docker ps -aq -f name=$(CONTAINER_NAME))" ]; then \
		echo "Container does not exist, creating and starting"; \
		docker run -d --name $(CONTAINER_NAME) -p $(NGINX_PORT):80 $(IMG_TAG); \
	elif [ -z "$$(docker ps -q -f name=$(CONTAINER_NAME))" ]; then \
		echo "Container exists but stopped, starting"; \
		docker start $(CONTAINER_NAME); \
	else \
		echo "Container is already running."; \
	fi

remove-container:
	docker rm -f $(CONTAINER_NAME)

add-nginx-endpoint:

# Copy the NGINX configuration to the running container
	docker cp nginx-config-with-endpoint.conf $(CONTAINER_NAME):/usr/local/nginx/conf/nginx.conf
# Reload NGINX configuration without restarting the container
	docker exec -it $(CONTAINER_NAME) /usr/local/nginx/sbin/nginx -s reload

check:
# Perform a network request to the specified endpoint
	curl http://localhost:$(NGINX_PORT)/similarweb-home-assignment && echo || echo failed