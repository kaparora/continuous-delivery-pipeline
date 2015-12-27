#! /bin/bash

PORT=9494

echo "Staring application with docker compose"
docker-compose build
docker-compose up -d
echo "Sleeping for 20 seconds for web service and sc agent to start"
sleep 20s
echo "calling the webservice to see if it is active and returns http code 200"
#curl -s --head --request GET  http://localhost:9292/locandtweet/netapp | grep "200 OK" > /dev/null
httpCode=`curl -sL -w "%{http_code}\\n" "http://10.65.57.126:$PORT/table/employees" -o /dev/null`
echo "Http code returned: $httpCode"
if [ $httpCode == 200 ]
then
        echo "deployment success"
	exit 0
else
	echo "deployment  failed"
	exit 1
fi

