# Dockerizing an Angular 17 Application

## Introduction

Docker provides a convenient way to package and distribute applications in a consistent environment. This repository contains a guide and example Dockerfile for Dockerizing an Angular 17 application.

## Prerequisites

Before you start, ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Node.js](https://nodejs.org/) (with npm)
- Basic knowledge of Angular and Docker

## Step 1: Setting Up Your Angular 17 Project

If you don't have an Angular 17 project yet, you can create one using the Angular CLI:

```bash
npm install -g @angular/cli@17
ng new my-angular-app
cd my-angular-app
```

## Step 2: Creating the Dockerfile

In the root of your Angular project, create a file named `Dockerfile`. This file contains the instructions for building and running your application inside a Docker container.

Here's a sample `Dockerfile` for an Angular 17 application:

```dockerfile
# Step 1: Build the Angular app
FROM node:21.7.3-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install --force
RUN npm install -g @angular/cli@17
COPY . .
RUN npm run build --prod

# Step 2: Serve the app using NGINX
FROM nginx:alpine
COPY --from=build /app/dist/my-angular-app/browser /usr/share/nginx/html
EXPOSE 80
```

### Explanation:

1. **Build Stage**:
   - Use the `node` image to build the Angular app.
   - `WORKDIR /app` sets the working directory in the container.
   - `COPY package*.json ./` copies the package files.
   - `RUN npm install --force` installs project dependencies.
   - `RUN npm install -g @angular/cli@17` installs Angular CLI globally.
   - `COPY . .` copies the project files.
   - `RUN npm run build --prod` builds the Angular application in production mode.

2. **Production Stage**:
   - Use the `nginx` image to serve the Angular app.
   - `COPY --from=build /app/dist/my-angular-app/browser /usr/share/nginx/html` copies the build output to the NGINX server directory.
   - `EXPOSE 80` makes port 80 available for the web server.

## Step 3: Adding a `.dockerignore` File

Create a `.dockerignore` file in the root of your Angular project to exclude unnecessary files and directories from the Docker build context. Add the following content to the `.dockerignore` file:

```
node_modules
npm-debug.log
Dockerfile*
.dockerignore
.git
.gitignore
README.md
LICENSE
.vscode
dist
```

This will ensure that these directories and files are not included in the Docker image, keeping it clean and efficient.

## Step 4: Building and Running the Docker Container

To build the Docker image, use the following command:

```bash
docker build -t my-angular-app .
```

### Explanation:

- `docker build` is the command to build a Docker image from a Dockerfile.
- `-t my-angular-app` tags the image with the name `my-angular-app`. You can use this tag to refer to the image later.
- `.` specifies the build context, which is the current directory. Docker will use this directory to look for the Dockerfile and other files needed for the build.

To run the Docker container:

```bash
docker run -d -p 8080:80 my-angular-app
```

### Explanation:

- `-d` runs the container in detached mode, allowing it to run in the background.
- `-p 8080:80` maps port 8080 on your host machine to port 80 on the container.
- `my-angular-app` is the name of your Docker image.

Your Angular app should now be accessible at `http://localhost:8080`.

## Step 5: Verifying Your Setup

Open a web browser and go to `http://localhost:8080`. You should see your Angular application running inside the Docker container.

## Conclusion

Dockerizing your Angular 17 application ensures a consistent environment for deployment. This guide provided a straightforward setup to get your Angular app running with Docker. Customize the Dockerfile as needed for your specific use case.

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Angular Documentation](https://angular.io/docs)
- [NGINX Documentation](https://nginx.org/en/docs/)
