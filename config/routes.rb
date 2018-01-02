Rails.application.routes.draw do
  root 'user_interface#index'

  get 'user_interface/index'

  get 'twilio/test_voice'
  get 'twilio/fizzbuzz'
  get 'twilio/say_fizzbuzz'
  post 'twilio/make_call'
end
