require 'rubygems'
require 'em-websocket'
# push all serial incoming data to websocket

# serial socket gateway connection
HOST = 'localhost'
PORT = 8782

RECONNECT_INTERVAL = 5

class SerialClient < EM::Connection
  def initialize(channel)
    @channel = channel
  end
  def post_init
    @channel.push  "serial connect!! - #{HOST}:#{PORT}"
    EM::defer do
      loop do
        send_data gets.gsub(/[\r\n]/, '')
      end
    end
  end

  def receive_data(data)
    @channel.push "arduino receive: #{data}"
  end

  def unbind
    @channel.push "connection to serial closed - #{HOST}:#{PORT}"
    EM::add_timer(RECONNECT_INTERVAL) do
      @channel.push "going to reconnect to serial.."
      reconnect(HOST, PORT)
    end
  end
end


EventMachine.run {
  # channel beetween websockets and serial
  @channel = EM::Channel.new

  EM::connect(HOST, PORT, SerialClient, @channel)

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    ws.onopen {
      # push to websockets
      sid = @channel.subscribe { |msg| ws.send msg }
      @channel.push "websocket client #{sid} connected!"

      ws.onclose {
        @channel.unsubscribe(sid)
      }

    }
  end

  puts "Server started"
}
