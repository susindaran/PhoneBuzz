require 'rubygems'
require 'sinatra'
require 'twilio-ruby'

get '/hello-monkey' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.say 'Hello Monkey'
  end.to_s
end

get '/fizzbuzz' do
  Twilio::TwiML::VoiceResponse.new do |response|

    response.gather(input: 'dtmf', action: '/start-fizzbuzz', method: 'GET') do |gather|
      gather.say('Please enter a number')
    end

    response.say('You did not enter any number')

  end.to_s
end

get '/start-fizzbuzz' do
  number = params['Digits'].to_i
  Twilio::TwiML::VoiceResponse.new do |response|
    for i in 1..number
      response.say convert_number(i)
    end
  end.to_s
end

def convert_number( number )
  if number % 3 == 0 and number % 5 == 0
    return 'Fizz Buzz'
  end

  if number % 3 == 0
    'Fizz'
  elsif number % 5 == 0
    'Buzz'
  else
    number.to_s
  end
end