#!/bin/bash

user=$USER

sudo bash -c 'echo "'$user' ALL=(ALL) NOPASSWD: /sbin/shutdown" > /etc/sudoers.d/shutdown'
