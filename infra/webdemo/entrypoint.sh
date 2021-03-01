#!/bin/sh
git clone https://github.com/robotframework/WebDemo.git ./EXERCISES/webdemo_selenium2library
sed -i "s|localhost:7272|webdemo:7272|g" ./EXERCISES/webdemo_selenium2library/login_tests/resource.robot
sed -i "s|localhost|0.0.0.0|g" ./EXERCISES/webdemo_selenium2library/demoapp/server.py
chmod -Rv 777 ./EXERCISES/webdemo_selenium2library
echo "START WITH:"
python --version
cd ./EXERCISES/webdemo_selenium2library/demoapp/
python server.py






