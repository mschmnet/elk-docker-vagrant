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
