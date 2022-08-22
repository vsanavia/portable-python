#!/bin/bash

#TIME_TO_SHUTDOWN=3600

#mkdir -p /home/pyuser/notebook

# In case fly volumes put something there
#rm -rf '/home/pyuser/notebook/lost+found'

#if [ -z "$(ls -A /home/pyuser/notebook)" ]; then
    #echo "Preparing notebook"
    #rm -rf /home/pyuser/notebook
    #git clone $GIT_REPO /notebook

    #cd /home/pyuser/notebook

#fi

#code-server --bind-addr 0.0.0.0:9090 /home/pyuser/notebook #&
    #/tired-proxy --port 8080 --host http://localhost:9090 --time $TIME_TO_SHUTDOWN
#su pyuser
/home/pyuser/.venv/bin/jupyter notebook --ip=0.0.0.0 --port=9999