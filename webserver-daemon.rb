require 'rubygems'        # if you use RubyGems
require 'daemons'

options = {
  :app_name   => "webserver",
  :dir_mode   => :script,
  :dir        => ".",
  :log_output => true,
  :backtrace  => true
}

pwd = Dir.pwd
Daemons.run_proc('sinatra-app.rb', options) do
  Dir.chdir(pwd)
  exec "ruby sinatra-app.rb"
end
