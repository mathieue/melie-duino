require 'rubygems'        # if you use RubyGems
require 'daemons'

options = {
  :app_name   => "broker",
  :dir_mode   => :script,
  :dir        => ".",
  :log_output => true,
  :backtrace  => true
}

Daemons.run(File.join(File.dirname(__FILE__), 'broker.rb'), options)
