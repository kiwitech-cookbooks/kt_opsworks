#!/usr/bin/env bash

eval "$(ssh-agent -s)"
ssh-add /home/kiwitech/sshkey
#ssh -o "StrictHostKeyChecking no" git@github.com &> /dev/null
/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "/home/kiwitech/sshkey" git@github.com $1 $2 &> /dev/null
