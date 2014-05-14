KeymailExample::Application.routes.draw do

  root 'messages#index'

  resource :messages

  post 'send_keymail',  to: 'sessions#send_keymail'
  get  'auth/:url_key', to: 'sessions#verify_link', as: 'keymail_link_target'
  get 'log_out',        to: 'sessions#log_out'
end
