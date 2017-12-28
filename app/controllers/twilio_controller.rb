require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  include FizzBuzzHelper

  after_action :set_xml_content_type
  skip_before_action :verify_authenticity_token

  def test_voice
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
    end

    render_as_xml response
  end

  def fizzbuzz
    response = Twilio::TwiML::VoiceResponse.new do |response|

      response.gather(input: 'dtmf', action: '/say-fizzbuzz', method: 'GET') do |gather|
        gather.say('Please enter a number')
      end

      response.say('You did not enter any number')

    end

    render_as_xml response
  end

  def say_fizzbuzz
    number = params['Digits'].to_i
    response = Twilio::TwiML::VoiceResponse.new do |response|
      (1..number).each do |i|
        response.say FizzBuzzHelper::convert_number(i)
      end
    end

    render_as_xml response
  end

end
