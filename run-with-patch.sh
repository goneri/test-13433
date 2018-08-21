#!/bin/bash
docker run --rm -it $(sed -i 's,#*RUN,RUN,' Dockerfile|docker build -q .)
