Rails.application.routes.draw do

  root 'institutions#index'

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      get '/contacts/:id', to: 'contacts#show'
    end
  end

  resources :institutions, path: 'instituciones',
    path_names: { new: 'nueva', edit: 'editar', show: 'detalles' } 

  resources :dependencies, path: 'dependencias',
    path_names: { new: 'nueva', edit: 'editar', show: 'detalles' }

  resources :offices, path: 'oficinas',
    path_names: { new: 'nueva', edit: 'editar', show: 'detalles' }

end
