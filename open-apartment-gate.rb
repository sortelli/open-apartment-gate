require 'sinatra'
require 'plivo'

def open_gate_response_xml()
  resp = Plivo::Response.new()

  speaking_params = {
    'language': 'en-US',
    'voice':    'WOMAN'
  }

  resp.addDTMF('WWW1WWW', {'async': false})

  resp.addSpeak('Please wait while I automatically open the gate', speaking_params)

  resp.addDTMF('9w9w9w9', {'async': false})

  resp.addSpeak('Goodbye', speaking_params)

  return resp.to_s()
end

get '/open-apartment-gate/' do
  content_type 'text/xml'
  return open_gate_response_xml()
end

post '/open-apartment-gate/' do
  content_type 'text/xml'
  return open_gate_response_xml()
end
