#!/bin/bash

code-server --bind-addr 127.0.0.1 --hashed-password "$argon2i$v=19$m=4096,t=3,p=1$2hNP0E7fg01eyIBPJa8Z0g$CAkt2RD9emoqgXMiRVqxVLc4yENEsDJJoOOfheqYbNM" /home/pyuser/notebook &
    #/tired-proxy --port 8080 --host http://localhost:9090 --time $TIME_TO_SHUTDOWN
#su pyuser
/home/pyuser/.venv/bin/jupyter notebook --ip=0.0.0.0 --port=8787 --certfile=/home/pyuser/.tls/localhost.pem \
--keyfile=/home/pyuser/.tls/localhost.key --no-browser --allow-root --NotebookApp.token='' \
--NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=/notebook \
--NotebookApp.notebook_dir=/home/pyuser/notebook