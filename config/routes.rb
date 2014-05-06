KeymailExample::Application.routes.draw do

  root 'messages#index'

  resource :messages

  get 'send_keymail', to: 'sessions#send_keymail'
  get  'auth/:url_key', to: 'sessions#verify_link', as: 'keymail_link_target'
end
