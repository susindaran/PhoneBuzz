require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  include FizzBuzzHelper

  skip_before_action :verify_authenticity_token
  after_action :set_xml_content_type

  def test_voice
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say 'This is a test message. Over and out!', :voice => 'alice'
    end

    render_as_xml response
  end

  def fizzbuzz
    response = Twilio::TwiML::VoiceResponse.new do |response|

      response.gather(input: 'dtmf', action: "/twilio/say_fizzbuzz?log_id=#{params[:log_id]}", method: 'GET') do |gather|
        gather.say('Please enter a number.')
      end

      response.say('You did not enter any number.')

    end

    render_as_xml response
  end

  def say_fizzbuzz
    digits = params['Digits'].to_i
    call_log = CallLog.find(params[:log_id])
    call_log.digits = digits
    logger.error 'Unable to update log record' unless call_log.save

    response = Twilio::TwiML::VoiceResponse.new do |response|
      (1..digits).each do |i|
        response.say FizzBuzzHelper::convert_number(i)
      end
    end

    render_as_xml response
  end
end
