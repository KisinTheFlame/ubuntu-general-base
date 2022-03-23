FROM ubuntu:20.04
COPY sources.list /etc/apt/
RUN apt update
RUN apt install -y vim curl net-tools openssh-client openssh-server sudo
RUN echo "root:kisintheflame" | chpasswd \
    && useradd -s /bin/bash kisin \
    && echo "kisin:kisintheflame" | chpasswd \
    && mkdir /home/kisin \
    && chown kisin /home/kisin \
    && chmod u+rwx /home/kisin
RUN mkdir /etc/kinit.d \
    && mkdir /etc/kinit.d/sh \
    && touch /etc/kinit.d/hosts
COPY ssh.sh /etc/kinit.d/sh
COPY kinit.sh /etc
ENTRYPOINT sh /etc/kinit.sh && /bin/bash