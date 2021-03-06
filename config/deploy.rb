# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'mail-stanium'
set :repo_url, 'https://github.com/catfood/mail-stanium.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/usr/local/www/apps/mail-stanium'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

#desc "Run the super-awesome rake task"
#task :super_awesome do
#  rake = fetch(:rake, 'rake')
#  rails_env = fetch(:rails_env, 'production')
#  run "cd '#{current_path}' && #{rake} super_awesome RAILS_ENV=#{rails_env}"
#end
#    execute :rake, 'db:migrate'

namespace :deploy do

  desc 'Publish application'
  task :publishing do
#    execute :bundle, 'install --path vendor'
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      #execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

module GitStrategy
  require 'capistrano/git'
  include Capistrano::Git::DefaultStrategy
  def release
    git :archive, fetch(:branch), '| tar -x -f - -C', release_path
  end
end

set :git_strategy, GitStrategy

