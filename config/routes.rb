Rails.application.routes.draw do
  root 'currency_exchange_pairs#index'
  resources :currency_exchange_pairs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
