class UserInterfaceController < ApplicationController

  before_action :create_call_log, only: [:make_call, :make_bypass_call]
  before_action :load_twilio_creds

  def index
    @call_logs = CallLog.all
  end

  def make_bypass_call
    call_log = CallLog.find(params[:id])
    url = "#{@api_host}/twilio/say_fizzbuzz"

    schedule_call(call_log.delay, call_log.number, url, 'GET', {Digits: call_log.digits})
  end

  def make_call
    target_phone_number = params['phone_number']
    delay = params['delay']
    url = "#{@api_host}/twilio/fizzbuzz"

    schedule_call(delay, target_phone_number, url, 'GET')
  end

  private

  def schedule_call(delay, target_phone_number, url, method, params = {})
    @message = "#{target_phone_number} will be getting a call in #{delay}!"
    @alert_type = 'alert-success'
    response_status_code = 200

    begin
      @call_log.attributes = {number: target_phone_number, delay: delay}
      raise Exception.new('Unable to record the call log') unless @call_log.save
      params[:log_id] = @call_log.id

      client = Twilio::REST::Client.new(@twilio_account_sid, @twilio_token)

      @job_id = Rufus::Scheduler.singleton.in delay do
        client.calls.create(
            url: url + "?#{params.to_query}",
            method: method,
            to: target_phone_number,
            from: @twilio_number
        )
      end

      logger.debug "Job ID: #{@job_id}"
    rescue => e
      logger.tagged('Make Call') { logger.error e }
      @message = 'An error occurred while making the call!'
      @alert_type = 'alert-danger'
      response_status_code = 500
    end

    respond_to do |format|
      format.js { render make_call_path, status: response_status_code }
    end
  end

  def create_call_log
    @call_log = CallLog.new
  end

  def load_twilio_creds
    @twilio_account_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_app_sid = ENV['TWILIO_APP_SID']
    @twilio_bypass_app_sid = ENV['TWILIO_BYPASS_APP_SID']
    @twilio_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_number = ENV['TWILIO_NUMBER']
    @api_host = ENV['API_HOST']
  end
end
