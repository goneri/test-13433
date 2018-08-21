#!/bin/bash
docker run --rm -it $(sed -i 's,\(RUN cd /usr\),#\1,' Dockerfile|docker build -q .)
