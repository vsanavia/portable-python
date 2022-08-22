#Using latest version (v3.8) available on Aug-2022
FROM python:3.8.13-slim-buster AS builder

LABEL version="0.1-beta"

#Using latest version from 3.8 major release available on Aug-2022
#ARG PYTHON_VERSION=3.8

# Install all Python, pip and all its dependencies
#RUN apk add gcc musl-dev make
# Use bash shell
ENV SHELL=/bin/bash

RUN apt-get update && apt-get install -y \
  gcc \    
  # Tooling 
  git \
  curl \
  # openssh \
  # Dependency for python virtual environment
  virtualenv && \
  #Cleanup of apt-get cache to slim down image
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  curl -fsSL https://code-server.dev/install.sh | sh &&\
# Creation of user to run python tools, virtualenv and jupyter
  useradd -m -d /home/pyuser -s /bin/bash pyuser

WORKDIR /home/pyuser

USER pyuser

# Installation of Python DS related modules and Jupyterlab
ENV VIRTUAL_ENV=/home/pyuser/.venv
RUN virtualenv -p /usr/local/bin/python ~/.venv && \
  echo 'source ~/.venv/bin/activate' >> ~/.bashrc 
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir \
  numpy \
  pandas \
  matplotlib \
  jupyterlab

#RUN && ssh-keygen -A \
#    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config

# create user SSH configuration
#RUN mkdir -p /home/pyuser/.ssh \
    # only this user should be able to read this folder (it may contain private keys)
    #&& chmod 0700 /home/pyuser/.ssh
    # unlock the user
    #&& passwd -u root

#ARG ssh_pub_key

#RUN echo "$ssh_pub_key" > /home/pyuser/.ssh/authorized_keys    

# prepare build dir
WORKDIR /home/pyuser/notebook

COPY settings.json /root/.local/share/code-server/User/settings.json

# Use our custom entrypoint script first
COPY entrypoint.sh /home/pyuser/entrypoint.sh

ENTRYPOINT ["/home/pyuser/entrypoint.sh"]


