require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  include FizzBuzzHelper

  after_action :set_xml_content_type, only: [:test_voice, :fizzbuzz, :say_fizzbuzz]
  skip_before_action :verify_authenticity_token
  before_action :load_twilio_creds

  def test_voice
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say 'This is a test message. Over and out!', :voice => 'alice'
    end

    render_as_xml response
  end

  def fizzbuzz
    response = Twilio::TwiML::VoiceResponse.new do |response|

      response.gather(input: 'dtmf', action: '/twilio/say_fizzbuzz', method: 'GET') do |gather|
        gather.say('Please enter a number.')
      end

      response.say('You did not enter any number.')

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

  def make_call
    @target_phone_number = params['phone_number']

    client = Twilio::REST::Client.new(@twilio_account_sid, @twilio_token)

    call = client.calls.create(
        application_sid: @twilio_app_sid,
        to: @target_phone_number,
        from: @twilio_number
    )

    respond_to do |format|
      format.js
    end
  end

  def load_twilio_creds
    @twilio_account_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_app_sid = ENV['TWILIO_APP_SID']
    @twilio_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_number = ENV['TWILIO_NUMBER']
  end
end
