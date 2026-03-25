#!/bin/bash

# Delete ssh key
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.3.175
