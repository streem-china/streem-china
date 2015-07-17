#! /usr/bin/env puma

actioncable_path = '/var/www/streem-china/current/cable'

daemonize true
environment ENV['RAILS_ENV']
bind 'tcp://0.0.0.0:28080'
workers 1
threads 4, 8
pidfile "#{actioncable_path}/tmp/pids/puma.pid"
state_path "#{actioncable_path}/tmp/pids/puma.state"
stdout_redirect "#{actioncable_path}/log/puma_stdout.log", "#{actioncable_path}/log/puma_stderr.log"
