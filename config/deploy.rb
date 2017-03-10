set :application, "mirador_sul"
set :repo_url, "https://github.com/sul-dlss/mirador_sul.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/opt/app/mirador/#{fetch(:application)}"

set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle config/certs config/settings)
set :linked_files, %w(config/database.yml config/secrets.yml config/honeybadger.yml)

set :bundle_without, %w(deployment development test).join(' ')

# honeybadger_env otherwise defaults to rails_env
set :honeybadger_env, fetch(:stage)

# update shared_configs before restarting app
before 'deploy:restart', 'shared_configs:update'
