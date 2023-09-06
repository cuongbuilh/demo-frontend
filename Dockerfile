FROM node:18-alpine as build
LABEL authors="cuongbuilh@gmail.com"

WORKDIR /app
COPY .npmrc package*.json yarn.lock ./
RUN yarn
COPY . .
RUN yarn run build

# ----
FROM nginx:stable
LABEL authors="cuongbuilh@gmail.com"
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/demo-frontend /usr/share/nginx/html

