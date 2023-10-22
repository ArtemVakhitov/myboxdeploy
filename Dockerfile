FROM ubuntu:18.04
RUN apt update
RUN apt install git maven docker.io -y
COPY ./.ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
COPY dockersecret /root/dockersecret
RUN chmod 600 /root/dockersecret