![portable-python icon](/images/icon.png)

# **portable-python**

Containerized python development environment (or poor man's codespaces ;)). The default configuration is intended to be used as a datascience focused environment and has the following components:

1. Based on the official [Python 3.8.13 slim image](https://hub.docker.com/_/python ).

2. Python runs on a virtual environment created with the [virtualenv](https://virtualenv.pypa.io/en/latest/) utility.

3. [NumPy](https://numpy.org/), [pandas](https://pandas.pydata.org/) and [matplotlib](https://matplotlib.org/) python modules are preinstalled by default. 

4. [Jupyterlab](https://jupyter.org/) is preinstalled and run by the entrypoint.sh script.

5. [code-server](https://github.com/coder/code-server) to allow running [VS Code] on your browser from any machine

# Instructions

On a machine with docker (tested with [docker desktop](https://www.docker.com/products/docker-desktop/)), clone the portable python git repository:

```
git clone https://github.com/vsanavia/portable-python.git
```

Docker build your development environment:

```
docker build -t vsanavia/portable-python .
```
Run your containerized development environment exposing ports 9090 (VS code web) and 8787 (Jupyter notebook)

```
docker run -it -p 9090:9090 -p 8787:8787 vsanavia/portable-python
```
VS Code will be available at http://localhost:9090 (without encryption as the self signed SSL certificate creates issues with extensions installations) and Jupyter notebook at https://localhost:8787 with a self signed SSL certificate.

To access VS Code from a remote machine, you can point your browser (tested from Chrome, Firefox and Safari on Mac) to [http://localhost:9090](https://localhost:9090/). 

To access Jupyter notebook from a remote machine, you can point your browser (tested from Chrome, Firefox and Safari on Mac) to [https://localhost:8787](https://localhost:8787/).

Choose the available kernel on the virtual environment (.venv) (shown on the VS COde web interface and start coding. 

![Choosing kernel](/images/kernel-choice.png)

```