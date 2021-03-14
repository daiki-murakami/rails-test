#!/bin/bash -l
set -Ceu

cd /var/www/projects/rails-test
git pull
bundle install --path vendor/bundle
bundle exec rails assets:precompile RAILS_ENV=production
