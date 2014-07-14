require 'rubygems'
require 'bundler/setup'
require 'faye/websocket'
require 'eventmachine'
require 'json'

port   = ARGV[0] || 7000
secure = ARGV[1] == 'ssl'

def load(check)
  puts check
end

send('load',1)

EM.run {
  scheme  = secure ? 'wss' : 'ws'
  url     = "#{scheme}://localhost:#{port}/"
  headers = {'Origin' => 'http://faye.jcoglan.com'}
  ws      = Faye::WebSocket::Client.new(url, nil, :headers => headers)

  puts "Connecting to #{ws.url}"

  ws.onopen = lambda do |event|
    p [:open]
    puts event
    data = {"command" => "send_to_all", "message" => "Hello!" }
    ws.send(data.to_json)
  end

  ws.onmessage = lambda do |event|
    p [:message, event.data]
    # ws.close 1002, 'Going away'
  end

  ws.onclose = lambda do |event|
    p [:close, event.code, event.reason]
    EM.stop
  end
}