#### PRODUCTION DOCKERFILE
### MULTI STEP DOCKER FILE: build + run

#tag the build phase ---> will create /app/build folder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#run phase
FROM nginx as runner
#specify we want to copy from previous phase: folder source - folder destination
COPY --from=builder /app/build /usr/share/nginx/html

#per lanciarlo
# docker build .
# docker run -p 8080:80 <ID>  (80 è la porta di default usata da nginx)