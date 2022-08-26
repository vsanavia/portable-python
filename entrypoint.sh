#!/bin/bash

code-server /home/pyuser/notebook &
    #/tired-proxy --port 8080 --host http://localhost:9090 --time $TIME_TO_SHUTDOWN
#su pyuser
/home/pyuser/.venv/bin/jupyter notebook --ip=0.0.0.0 --port=8787 --certfile=/home/pyuser/.tls/localhost.pem \
--keyfile=/home/pyuser/.tls/localhost.key --no-browser --allow-root --NotebookApp.token='' \
--NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=/notebook \
--NotebookApp.notebook_dir=/home/pyuser/notebook