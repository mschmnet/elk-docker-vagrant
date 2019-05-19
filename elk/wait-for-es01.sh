#!/bin/bash

set -eo pipefail

host="$1"
shift
start_command="$@"
until bash elasticsearch-healthcheck.sh "$host"
do
  echo "Elasticsearch not ready yet..."
  sleep 5
done

echo "Elasticsearch is READY! Starting $start_command now"

exec $start_command 


