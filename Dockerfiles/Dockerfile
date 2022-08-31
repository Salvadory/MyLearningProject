FROM ubuntu:latest

RUN apt update && apt -y install nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
