# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'streem-china'
set :repo_url, 'git@github.com:streem-china/streem-china.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, ['config/database.yml',
                    'config/secrets.yml',
                    'config/newrelic.yml']

# Default value for linked_dirs is []
set :linked_dirs, ['bin',
                   'log',
                   'tmp/pids',
                   'tmp/cache',
                   'tmp/sockets',
                   'vendor/bundle',
                   'cable/log',
                   'cable/tmp/pids']

set :bundle_without, %w{development test sqlite postgres}.join(' ')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
#
set :rbenv_ruby, '2.2.0'

set :puma_workers, 1
set :puma_threads, [4, 8]

set :nginx_server_name, 'streem-china.org'

after 'deploy:published', 'actioncable:restart'
