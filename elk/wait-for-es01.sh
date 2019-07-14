#!/bin/bash

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


