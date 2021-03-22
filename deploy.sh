#!/bin/bash -l
set -Ceu

cd /var/www/projects/rails-test
bundle install --path vendor/bundle
bundle exec rails assets:precompile RAILS_ENV=production

# unicorn再起動処理
pid=`cat tmp/pids/unicorn.pid`

kill -s USR2 $pid
sleep 3

kill -s WINCH $pid
sleep 3

kill -s QUIT $pid</pre>
