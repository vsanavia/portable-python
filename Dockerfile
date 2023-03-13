#Using latest version (v3.10) available on Mar-2023
FROM python:3.10.10-slim-bullseye AS builder

LABEL version="0.2.0-beta"

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
  curl &&\
  # openssh \
  # Dependency for python virtual environment
  # virtualenv && \
  #Cleanup of apt-get cache to slim down image
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  curl -fsSL https://code-server.dev/install.sh | sh &&\
# Creation of user to run python tools, virtualenv and jupyter
# mkdir -p /home/pyuser/.local/lib /home/pyuser/.local/bin && \
# curl -fL https://github.com/coder/code-server/releases/download/v4.6.1/code-server-4.6.1-linux-amd64.tar.gz \
# | tar -C /home/pyuser/.local/lib -xz && \
# mv /home/pyuser/.local/lib/code-server-4.6.1-linux-amd64 /home/pyuser/.local/lib/code-server-4.6.1 && \ 
# ln -s /home/pyuser/.local/lib/code-server-4.6.1/bin/code-server /home/pyuser/.local/bin/code-server && \
  useradd -m -d /home/pyuser -s /bin/bash pyuser && \
  chmod -R 777 /home/pyuser && \
  chown -R pyuser:pyuser /home/pyuser

ENV PATH="/home/pyuser/.local/bin:$PATH"
WORKDIR /home/pyuser

USER pyuser

# Installation of Python DS related modules and Jupyterlab
ENV VIRTUAL_ENV=/home/pyuser/.venv
RUN python -m venv ~/.venv && \
  echo 'source ~/.venv/bin/activate' >> ~/.bashrc 
COPY requirements.txt ./
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir \
 -r requirements.txt
# Generate self signed SSL certificate 
SHELL ["/bin/bash", "-c"]
RUN mkdir /home/pyuser/.tls && \
 openssl req -x509 -out /home/pyuser/.tls/localhost.pem -keyout /home/pyuser/.tls/localhost.key \
  -newkey rsa:4096 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=\
   DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

# Import jupyter notebook settings to use ssl and additional customizations
#COPY jupyter_notebook_config.py /home/pyuser/.jupyter/jupyter_notebook_config.py

# Import code-server settings to disable password
COPY config.yaml /home/pyuser/.config/code-server/config.yaml

# prepare build dir
WORKDIR /home/pyuser/notebook

COPY settings.json /root/.local/share/code-server/User/settings.json

# Use our custom entrypoint script first
COPY entrypoint.sh /home/pyuser/entrypoint.sh

ENTRYPOINT ["/home/pyuser/entrypoint.sh"]


