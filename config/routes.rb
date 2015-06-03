Rails.application.routes.draw do

  match '/api/v1/reports', to: 'reports#create', via: [:post, :options]

  match 'api/v1/reports/mapquery', to: 'reports#mapquery', via: [:get, :options]

  
  
end
