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


.RECIPEPREFIX=>
SHELL = /bin/bash -o pipefail

# Can be a version existing pip or git 
PIP_OR_GIT?="pip"

# Can be "latest" or a specific version
VERSION_OR_TAG?="0.2.0b2"

default: run

docker-build: docker-build-$(VERSION_OR_TAG).out

docker-build-%.out: Dockerfile
>docker build -t mschmnet/elastalert:${VERSION_OR_TAG} --build-arg PIP_OR_GIT=${PIP_OR_GIT} --build-arg VERSION_OR_TAG=$(VERSION_OR_TAG) . | tee $@

run: docker-build
>docker run --network=elk_esnet --volume "/vagrant/elk/config/elastalert/:/etc/elastalert/:ro" -it mschmnet/elastalert:$(VERSION_OR_TAG)

clean:
>rm docker-build.out

help:
>@echo docker-build run clean default


.PHONY: docker-build run clean help
