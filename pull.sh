#!/bin/bash -l
set -Ceu

cd /var/www/projects/rails-test
git checkout master
git checkout .
git pull
chmod +x deploy.sh