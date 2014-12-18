set :stage, :production
server '172.28.128.3', user: 'deploy', roles: %w{web app}

