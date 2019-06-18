#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM i386/ubuntu:12.04 

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y apt-utils sudo && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git man unzip vim wget tcl zlib1g-dev libncurses5-dev rpm ncurses-base m4 bison && \
  rm -rf /var/lib/apt/lists/*

#UN adduser noroot
RUN groupadd -r noroot -g 1000 && useradd -u 1000 -r -g noroot -m -d /home/noroot -s /sbin/nologin -c "Noroot user" noroot && chmod 755 /home/noroot
RUN echo "noroot ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/noroot && \
    chmod 0440 /etc/sudoers.d/noroot

RUN echo "root:Docker!" | chpasswd
	
COPY ltib.tar /home/noroot/ltib.tar
COPY ubuntu-12_04-ltib-patch.tgz /home/noroot/ltib.tar 
RUN mkdir /home/noroot/install
RUN tar -xvf /root/ltib.tar -C /home/noroot/install
 
# Add files.
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /home/noroot

# Define working directory.
WORKDIR /home/noroot

# Define default command.
USER noroot
CMD ["/bin/bash"]
