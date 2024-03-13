
# NGINX Docker Setup

This project involves setting up an NGINX server running inside a Docker container, with the capability to update the server's configuration without downtime.

## Features

- NGINX running inside a Docker container.
- Custom NGINX configuration with a predefined endpoint.
- Automatic reloading of NGINX configuration without restarting the container.
- Makefile for managing Docker tasks.

## Prerequisites

- Docker
- Make tool

## Setup

Clone this repository and navigate into the project directory:

```bash
git clone https://github.com/noyosi/nginx-docker-setup.git
cd nginx-docker-setup
```

## Usage

The project includes a Makefile with the following commands:

- `make build`: Builds the Docker image with NGINX installed.
- `make run-nginx`: Runs the NGINX server in a Docker container, binding port 8080 on the host.
  <br/>In case the container is running do nothing, in case the container is stopped: start it, and in case the container doesn't exists create and run it.
- `remove-container`: Removes the container if it's already exists.
- `make add-nginx-endpoint`: Adds a new endpoint `/similarweb-home-assignment` that returns a custom JSON response without downtime.
- `make check`: Checks if the custom endpoint is accessible and returns the expected response and if not print "failed".

## Configuration

### Dockerfile

The Dockerfile uses Alpine as a base image and installs NGINX manually to meet the assignment requirements.

### Makefile

Provides automation for building the Docker image, running the container, adding the NGINX endpoint, and checking the endpoint.


- Noy Osi
- Email: Noyosi2212@gmail.com
