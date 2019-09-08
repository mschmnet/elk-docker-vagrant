#!/bin/bash


curl_command="curl --silent -H \"Content-Type: application/json\" -d '"$3"' -X\"$1\" http://localhost:9200/$2"
echo "Request:" >2&
echo "$curl_command" >2&
echo "Response:" >2&


if [[ "$3" == "-" ]]
then
  cat - | docker exec es01 /bin/bash -c "$curl_command"
else
  docker exec es01 /bin/bash -c "$curl_command"
fi
