set :application, "motscaches"
set :repository,  "git@github.com:NormandLemay/motcacher.git"
set :scm, :git
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :user, "dq"

server "dansrc.com", :app, :web, :db, :primary => true

set :deploy_to, "/home/#{user}/#{application}.dansrc.com/#{application}"
set :public_html, "/home/#{user}/#{application}.dansrc.com/public_html"