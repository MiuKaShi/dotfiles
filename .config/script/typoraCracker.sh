#!/bin/bash

if [[ $EUID -eq 0 ]]; then
    echo -e "\n\e[31mError!\e[0m\n\nDo not use root to run scripts" 1>&2
    exit 1
fi

# Typora installation location
t_path=/usr/share/typora

# TyporaCracker location
c_path=/home/miuka/github/typoraCracker

rm -rf $c_path/build/*

echo "Check python dependencies"
pip install -r $c_path/requirements.txt

echo "Start unpacking..."
python $c_path/typora.py $t_path/resources/app.asar $c_path/build
echo "Unpacking Successfully!"

echo "Replace license profile."
cp $c_path/example/patch/License.js $c_path/build/dec_app
python $c_path/typora.py -u $c_path/build/dec_app $c_path/build

sudo cp $t_path/resources/app.asar $t_path/resources/app.asar.bak

sudo cp $c_path/build/app.asar $t_path/resources/app.asar
echo -e "\n\e[32mActivated Successfully!\e[0m"


echo -e "\nYour activation code：\c"
node $c_path/example/keygen.js

