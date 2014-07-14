require 'faye/websocket'
require 'json'
#static = Rack::File.new(File.dirname(__FILE__))
require '../config/environment'

@clients = []

def verified_user(api_token)
  # verify token here
end

def command_authenticate(ws, data)
  # here we will add the ws in the @clients hash after verifying the token
  # token should be sent in data i.e data['token']
  # for now @clietns is list, we can change it to hash and store ws object corresponding to user id
  #if verified_user(data['token'])
    @clients.push(ws)
  #end
end

def command_send_to_all(ws, data)
  for @client in @clients
    data = data.to_json
    @client.send(data)
  end
end

def command_ping(ws, data)
  ws.send("{'event':'pong'}")
end


App = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :message do |event|
      begin
        data = JSON.parse(event.data)
        command = data["command"]
        data.delete("command")
        send("command_"+command, ws, data)
      rescue NoMethodError
        ws.send("{'error':'Invalid Command'}")
      end
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]
      ws = nil
    end

    ws.rack_response
  else
    [200, {'Content-Type' => 'text/plain'}, ['Hello']]
  end
end