Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'twilio/test_voice'     => 'twilio#test_voice'
  get 'twilio/fizzbuzz'       => 'twilio#fizzbuzz'
  get 'twilio/say_fizzbuzz'   => 'twilio#say_fizzbuzz'
  post 'twilio/make_call'     => 'twilio#make_call'
end
