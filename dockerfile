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
COPY --from=build /app/dist/dockerize-angular-17/browser /usr/share/nginx/html
EXPOSE 80
