Rails.application.routes.draw do
  root 'rovers#new'
  get 'results', to: 'rovers#show'
  resource :rover, only: %i[create], path: 'calculate', as: 'calculate'

  get '/*undefined_route', to: redirect('/')
end
