#!/usr/bin/env bash

cd ./armcord
npm install
npm run build
npm run package
cd ../

cd ./dmenu
sudo make clean install
cd ../

cd ./dwm
sudo make clean install
cd ../

cd ./dwmblocks-async
sudo make clean install
cd ../

cd ./slock
sudo make clean install
cd ../

cd ./st
sudo make clean install
cd ../

cd ./tabbed
sudo make clean install
cd ../
