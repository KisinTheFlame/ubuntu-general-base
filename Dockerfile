FROM ubuntu:20.04
COPY sources.list /etc/apt/
RUN apt update
RUN apt install -y curl net-tools iputils-ping
RUN apt install -y vim sudo
RUN apt install -y openssh-client openssh-server
RUN apt install -y htop screen
RUN echo "root:kisintheflame" | chpasswd \
    && useradd -s /bin/bash kisin \
    && echo "kisin:kisintheflame" | chpasswd \
    && mkdir /home/kisin \
    && chown kisin /home/kisin \
    && chmod u+rwx /home/kisin \
    && echo "kisin ALL=(ALL:ALL) ALL" > /etc/sudoers.d/kisin
RUN mkdir /etc/kinit.d \
    && mkdir /etc/kinit.d/sh \
    && touch /etc/kinit.d/hosts
COPY ssh.sh /etc/kinit.d/sh
COPY kinit.sh /etc
ENTRYPOINT sh /etc/kinit.sh && /bin/bash