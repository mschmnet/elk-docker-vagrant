#!/bin/bash

chmod a-w /usr/share/filebeat/filebeat.yml
/usr/local/bin/docker-entrypoint -e
