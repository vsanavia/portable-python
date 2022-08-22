# **portable-python**

Containerized python development environment (or poor man's codespaces ;)). The default configuration is intended to be used as a datascience focused environment and has the following components:

1. Based on the official [Python 3.8.13 slim image](https://hub.docker.com/_/python ).

2. Python runs on a virtual environment created with the [virtualenv](https://virtualenv.pypa.io/en/latest/) utility.

3. [NumPy](https://numpy.org/), [pandas](https://pandas.pydata.org/) and [matplotlib](https://matplotlib.org/) are preinstalled by default. 

4. [Jupyterlab](https://jupyter.org/) is preinstalled and run by the entrypoint.sh script.