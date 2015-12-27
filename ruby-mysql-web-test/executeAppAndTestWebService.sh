#! /bin/bash

DOCKER_REPO=10.65.57.126:5000/ruby-twitter-api
TAG=0.0.1-SNAPSHOT
CONTAINER_NAME=hello-world-app-test
TEST_PORT=9393

echo "Staring application with docker compose"
docker-compose up -d
echo "Sleeping for 10 seconds for web service to start"
sleep 10s
echo "calling the webservice to see if it is active and returns http code 200"
#curl -s --head --request GET  http://localhost:9292/locandtweet/netapp | grep "200 OK" > /dev/null
httpCode=`curl -sL -w "%{http_code}\\n" "http://10.65.57.126:$TEST_PORT/table/employees" -o /dev/null`
echo "Http code returned: $httpCode"
if [ $httpCode == 200 ]
then
        echo "test passed!"
	exit 0
else
	echo "test failed"
	exit 1
fi

