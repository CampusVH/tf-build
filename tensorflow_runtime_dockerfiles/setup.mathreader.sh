#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt update
apt-get install -y git libgl1

git clone https://github.com/carolreis/mathreader.git
cd mathreader
if git show-ref refs/heads/master |grep ^8eec123f6332e5d505526d6b320d8802b247cd3c; then
	echo integrity of repository is okay
else
	echo repository has been unexpected changed
	exit 1
fi
sed -i 's/==2\.2\.0//' requirements.txt
python setup.py sdist bdist_wheel
pip install ./dist/mathreader-0.161-py3-none-any.whl
