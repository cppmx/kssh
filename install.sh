#!/bin/bash

if [ ! -f sh/kssh ]
then
   echo "You must be in the repository root to install kssh"
   exit 1
fi

if [ ! -d ~/bin ]
then
   mkdir ~/bin
fi
cp -v sh/kssh sh/kons_functions ~/bin
