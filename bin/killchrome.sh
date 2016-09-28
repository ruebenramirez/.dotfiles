#!/bin/bash

google-chrome&
google-chrome&
google-chrome&
google-chrome&
google-chrome&
google-chrome&
google-chrome&

while [ $(ps aux | grep chrome | egrep -v 'killchrome|grep' | wc -l) -gt 0 ]; do
    killall chrome;
done
