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

if [ ! -d ~/.config/kssh ]
then
   mkdir -p ~/.config/kssh/templates
fi

cp -vrp config/templates/* ~/.config/kssh/templates/

if [ ! -f ~/.config/kssh/config.sh ]
then
   echo "Installing kssh config file in ~/.config/kssh"
   cp -vp config/config.sh ~/.config/kssh
else
   echo "Installing original kssh config file in ~/.config/kssh as config.sh.new. If you need to refresh kssh configuration, compare it with your version."
   cp -vp config/config.sh ~/.config/kssh/config.sh.new
fi
