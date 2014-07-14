# require 'rubygems'
# require 'bundler/setup'
# require 'rack/content_length'
# require 'rack/chunked'

require 'faye/websocket'


port   = ARGV[0] || 7000
secure = ARGV[1] == 'ssl'
engine = ARGV[2] || 'thin'

require File.expand_path('../app', __FILE__)
Faye::WebSocket.load_adapter(engine)

case engine
  when 'thin'
    EM.run {
      thin = Rack::Handler.get('thin')
      thin.run(App, :Port => port) do |server|
      end
    }
end