#!/bin/sh

source ./test-helpers.sh

# This script tests container image build and runs a couple of
# tests against the generated image.

if [ -d ".venv" ]; then
    mv .venv .venv_temp
fi

docker build -t porting-advisor .
if [ $? -ne 0 ]; then
    echo "**ERROR**: building container image" && exit 1
fi

echo "Running container on samples to console"
docker run --rm -v $(pwd)/sample-projects:/source porting-advisor /source > console_test.txt
test_report 'console' 'console_test.txt' "${lines_to_find[@]}"
if [ $? -ne 0 ]; then
    echo "**ERROR**: running container to console" && exit 1
fi
rm console_test.txt

echo "Running container on samples to HTML report"
docker run --rm -v $(pwd):/source porting-advisor /source/sample-projects --output /source/test.html 
test_report 'html' 'test.html' "${lines_to_find[@]}"
if [ $? -ne 0 ]; then
    echo "**ERROR**: running container to html report" && exit 1
fi
rm -f test.html

if [ -d ".venv_temp" ]; then
    mv .venv_temp .venv
fi

exit 0
