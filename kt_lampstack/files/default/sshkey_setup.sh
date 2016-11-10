#!/usr/bin/env bash

eval "$(ssh-agent -s)"
ssh-add /home/ubuntu/sshkey
#ssh -o "StrictHostKeyChecking no" git@github.com &> /dev/null
/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "/home/ubuntu/sshkey" git@github.com $1 $2 &> /dev/null
