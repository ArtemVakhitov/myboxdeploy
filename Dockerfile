FROM ubuntu:18.04
RUN apt update
RUN apt install git maven docker.io -y
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa