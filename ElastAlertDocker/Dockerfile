# Copyright 2019 Manuel Schmidt 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Published at https://github.com/mschmnet/elk-docker-vagrant/


FROM ubuntu:bionic

RUN apt-get update && \
    apt-get -qy install python-pip python-dev libffi-dev libssl-dev git

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/UTC /etc/localtime

ARG PIP_OR_GIT=git
ARG VERSION_OR_TAG=v0.2.0b2

RUN if [ "$PIP_OR_GIT" = "git" ]; \
    then \
      pip install "setuptools>=11.3" && \
      git clone https://github.com/Yelp/elastalert.git && \
      cd elastalert && \
      git checkout origin/beta && \
      pip install "cryptography>=2.3" && \
      python setup.py install; \
    elif [ "$VERSION_OR_TAG" = "latest" ]; \
    then \
      pip install elastalert; \
    else \
      pip install elastalert==$VERSION_OR_TAG; \
    fi

RUN echo "#!/bin/bash" >> /entrypoint.sh && \ 
    echo "elastalert-create-index --host es01 --port 9200 --no-auth --no-ssl --index elastalert_status --url-prefix \"\" --old-index \"\" --alias elastalert_alerts" >> /entrypoint.sh && \
    echo "elastalert --es_debug_trace /dev/stdout --verbose --config /etc/elastalert/config/config.yaml" >> /entrypoint.sh && \
#    echo "elastalert-test-rule --debug --config /etc/elastalert/config/config.yaml /etc/elastalert/rules/any.yaml" >> /entrypoint.sh && \
#    echo "/bin/bash" >> /entrypoint.sh && \
    chmod +x /entrypoint.sh 

VOLUME /etc/elastalert/

ENTRYPOINT ["/entrypoint.sh"]
