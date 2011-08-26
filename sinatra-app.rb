require 'rubygems'
require 'sinatra'
require 'erb'
require 'socket'

# serial socket infos
HOST = "localhost"
PORT = 8782

def pin13(command)
  begin
    s = TCPSocket.open(HOST, PORT)
    s.putc command
  rescue => e
    STDERR.puts e
    exit 1
  end
end

get '/' do
  erb :index
end

get '/pin13on' do
  pin13 'a'
  'ok'
end

get '/pin13off' do
  pin13 'b'
  'ok'
end
