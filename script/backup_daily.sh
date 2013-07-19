#!/bin/bash

cd ~/Apps/album-club
heroku pgbackups:capture --expire
curl -o $(date "+backup-%Y-%m-%d.dump") `heroku pgbackups:url`
