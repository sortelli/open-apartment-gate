require 'sinatra'
require 'plivo'

def open_gate_response_xml()
  resp = Plivo::Response.new()

  src = ENV['OPENGATE_SRC_SMS_ALERT']
  dst = ENV['OPENGATE_DST_SMS_ALERT']

  if (src and dst)
    resp.addMessage('Intruder at the front gate. The Sphinx has spoken.', {
      'src':  src,
      'dst':  dst,
      'type': 'sms'
    })
  end

  resp.addDTMF('WWW1WWW', {'async': false})

  resp.addSpeak('Please wait while I automatically open the gate', {
    'language': 'en-US',
    'voice':    'WOMAN'
  })

  resp.addDTMF('9w9w9w9', {'async': false})

  resp.to_s()
end

def unauthorized_response_xml()
  resp = Plivo::Response.new()

  resp.addSpeak('Missing or incorrect authorization token', {
    'language': 'en-US',
    'voice':    'WOMAN'
  })

  resp.to_s()
end

get '/open-apartment-gate/' do
  content_type 'text/xml'

  if params['token'] == ENV['OPENGATE_AUTH_TOKEN']
    open_gate_response_xml()
  else
    unauthorized_response_xml()
  end
end
