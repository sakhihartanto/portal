FROM node:16-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install --verbose
COPY . .
RUN npm run build --verbose

FROM nginx:stable-alpine as main
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]