# Multistage Dockerfile and Docker Compose Example Project
This repository is created for the purpose of demonstrating the the use of **multi stage build** in docker and also how to make a **docker compose** file to deploy a simple next js app.

## Getting Started
Please remember to change to the working directory before executing all of the commands.

### Installing Docker & Docker Compose
You can see the official Docker documentation for installing Docker and Docker Compose. Visit [Docker Website](https://docs.docker.com/engine/install/) for more details.

### Build the Docker Image
This command is used to build the image from the Dockerfile and add my-web-image tag to that image. Run the following lines in a terminal:
```
docker build -t my-web-image .
```
The name of the tag is optional and you can name it anything you want. This steps is optional, because in the docker compose file that I made, it is already contain the command to build the image first.

### Run the Docker Container
To run the container, we can use the docker-compose.yaml file that I've already made. Run the following lines in a terminal:
```
docker compose up -d
```

To run the container manually, you can run the following lines in a terminal:
```
docker run -d -p 3000:3000 my-web-image 
```
This command runs the image that we made on the previous step. The -p 3000:3000 option is used to map the docker host port to the container port. The container port must be 3000 because the image expose the port 3000, but the docker host port can be anything you like, as long as it does not using a port that is already in use. 

The -d option is used for running the container in detach mode.

## Reasons and Explanations
### Dockerfile
We have to use multistage because docker build the image layer by layer. If we split it into multiple stages, we can isolate things that will oftenly change. For example, if only the stage 4 that is changed, docker will not build the image again from the beginning because docker has cache. It will only build the necessary things only.

I also use the alpine image because I want to make the image smaller.

I split the dockerfile into 4 stages:
1. Installing all of the dependencies, including the dependencies that we use for development. I make this stage because I want to exclude the dev dependencies in the final image.
2. Building the next js app.
3. Only installing the production dependencies, so that the final image can be smaller and lighter.
4. Copying the production dependencies and the builded image to the last stage, so that the final image only consist the prod dependencies and the data that is needed.