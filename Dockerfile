FROM ubuntu:18.04
RUN apt update
RUN apt install git maven docker.io -y