#!/bin/bash

if [[ "$3" == "-" ]]
then
  data="@-"
else
  data="$3"
fi

curl_command="curl --silent -H \"Content-Type: application/json\" -d '"$data"' -X\"$1\" http://localhost:9200${2}"
echo "Request:" >&2
echo "$curl_command" >&2
echo "Response:" >&2

if [[ "$data" == "@-" ]]
then
  cat - | docker exec -i es01 /bin/bash -c "$curl_command"
else
  docker exec -i es01 /bin/bash -c "$curl_command"
fi
