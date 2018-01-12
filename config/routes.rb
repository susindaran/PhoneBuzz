Rails.application.routes.draw do
  root 'user_interface#index'

  get 'user_interface/index'

  get 'twilio/test_voice'
  get 'twilio/fizzbuzz'
  get 'twilio/say_fizzbuzz'
  post 'user_interface/make_bypass_call/:id' => 'user_interface#make_bypass_call', as: 'make_bypass_call'
  post 'user_interface/make_call', as: 'make_call'
end
