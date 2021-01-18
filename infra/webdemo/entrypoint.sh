#!/bin/sh
git clone https://github.com/robotframework/WebDemo.git ./EXERCISES/webdemo
sed -i "s|localhost:7272|webdemo:7272|g" ./EXERCISES/webdemo/login_tests/resource.robot
sed -i "s|localhost|0.0.0.0|g" ./EXERCISES/webdemo/demoapp/server.py
chmod -Rv 777 ./EXERCISES/webdemo
echo "START WITH:"
python --version
cd ./EXERCISES/webdemo/demoapp/
python server.py






