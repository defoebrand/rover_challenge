Rails.application.routes.draw do
  root 'rovers#new'
  get 'results', to: 'rovers#show'
  # resource :rover, except: %i[new show edit update delete]
  resource :rover, only: %i[create], path: 'calculate', as: 'calculate'

  # resource :rover, only: %i[create], as: 'nasa' do
  #   get 'results', to: 'rovers#show'
  # end
  # scope(path_names: { show: 'results' }) do
  #   resource :rover, only: %i[create show]
  # end
  # scope(path_names: { new: 'neu', edit: 'bearbeiten' }) do
  #   resources :categories, path: 'kategorien'
  # end
end
