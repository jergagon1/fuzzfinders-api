Rails.application.routes.draw do

  # FuzzFinders Reports
  match '/api/v1/reports', to: 'reports#create', via: [:post, :options]

  match 'api/v1/reports/mapquery', to: 'reports#mapquery', via: [:get, :options]

  # User Auth
  match '/api/v1/users', to: 'users#create', via: [:post, :options]
  match '/api/v1/logged_in', to: 'users#logged_in', via: [:get, :options]
  match '/api/v1/log_in', to: 'users#log_in', via: [:put, :options]
  match '/api/v1/log_out', to: 'users#log_out', via: [:put, :options]

  # FuzzFeed
  match 'api/v1/articles', to: 'articles#index', via: [:get, :options]
  match 'api/v1/articles/:id', to: 'articles#show', via: [:get, :options]
  match 'api/v1/articles', to: 'articles#create', via: [:post, :options]

end
