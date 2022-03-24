#!/bin/bash

if [[ -z $1 ]]
then
    echo "list | NAME"
elif [[ $1 == "list" ]]
then
    ls /etc/ksource.d
else
    cat /etc/ksource.d/$1 > /etc/apt/source.list
fi