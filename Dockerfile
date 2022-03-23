FROM ubuntu:20.04
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt update
RUN apt install -y vim curl net-tools openssh-client openssh-server sudo
RUN echo "root:kisintheflame" | chpasswd \
    && useradd -s /bin/bash kisin \
    && echo "kisin:kisintheflame" | chpasswd \
    && mkdir /home/kisin \
    && chown kisin /home/kisin \
    && chmod u+rwx /home/kisin
RUN mkdir /etc/kinit.d \
    && echo "service ssh start" > /etc/kinit.d/ssh.sh \
    && echo 'for file in `ls /etc/kinit.d`' > /etc/kinit.sh \
    && echo "do" >> /etc/kinit.sh \
    && echo '  sh /etc/kinit.d/$file' >> /etc/kinit.sh \
    && echo "done" >> /etc/kinit.sh
ENTRYPOINT sh /etc/kinit.sh && /bin/bash