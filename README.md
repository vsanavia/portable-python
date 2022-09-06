![GitHub](https://img.shields.io/github/license/vsanavia/portable-python)
![GitHub last commit](https://img.shields.io/github/last-commit/vsanavia/portable-python)
![GitHub followers](https://img.shields.io/github/followers/vsanavia?style=social)
[![Medium vsanavia](https://img.shields.io/badge/medium.com%2F@vsanavia-subscribe-blueviolet)](https://medium.com/@vsanavia)
![Twitter Follow](https://img.shields.io/twitter/follow/vsanavia?style=social)
[![ci](https://github.com/vsanavia/portable-python/actions/workflows/build-push.yml/badge.svg?event=push)](https://github.com/vsanavia/portable-python/actions/workflows/build-push.yml)
![portable-python icon](/images/icon.png)


# **portable-python**

Containerized python development environment (or poor man's codespaces ;)). The default configuration is intended to be used as a datascience focused environment and has the following components:

1. Based on the official [Python 3.8.13 slim image](https://hub.docker.com/_/python ).

2. Python runs on a virtual environment created with the [virtualenv](https://virtualenv.pypa.io/en/latest/) utility.

3. [NumPy v. 1.23.2](https://numpy.org/), [pandas v. 1.4.3](https://pandas.pydata.org/) and [matplotlib v. 3.5.3](https://matplotlib.org/) python modules are preinstalled by default. 

4. [Jupyterlab v. 3.4.5](https://jupyter.org/) is preinstalled and run by the entrypoint.sh script.

5. [code-server](https://github.com/coder/code-server) to allow running [VS Code] on your browser from any machine

# Instructions

On a machine with docker (tested with [docker desktop](https://www.docker.com/products/docker-desktop/)), clone the portable python git repository:

```
git clone https://github.com/vsanavia/portable-python.git
```
Enter the portable-python directory:

```
cd portable-python
```
Docker build your development environment:

```
docker build -t vsanavia/portable-python .
```
Run your containerized development environment on the background (detached mode) exposing ports 9090 (VS code web) and 8787 (Jupyter notebook)

```
docker run -d -p 9090:9090 -p 8787:8787 --name popy-container vsanavia/portable-python
```
VS Code will be available at http://localhost:9090 (without encryption as the self signed SSL certificate creates issues with extensions installations) and Jupyter notebook at https://localhost:8787 with a self signed SSL certificate.

To access VS Code from a remote machine, you can point your browser (tested from Chrome, Firefox and Safari on Mac) to [http://localhost:9090](https://localhost:9090/). 

To access Jupyter Lab from a remote machine, you can point your browser (tested from Chrome, Firefox and Safari on Mac) to [https://localhost:8787/notebook](https://localhost:8787/notebook). You will receive a warning about an untrusted certificate on the first visit.

Choose the available kernel on the virtual environment (.venv) (shown on the VS Code web interface and start coding.

![Choosing kernel](/images/kernel-choice.png)

```