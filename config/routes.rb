Rails.application.routes.draw do
  # Devise Authentication
  scope :api do
    scope :v1 do
      devise_for :users, controllers: {
        registrations: 'registrations',
        sessions: 'sessions'
      }
    end
  end

  # TODO: rewrite all routes in resource style

  # FuzzFinders Reports
  match '/api/v1/reports', to: 'reports#create', via: [:post, :options]
  match '/api/v1/reports/:report_id', to: 'reports#update', via: [:put, :options]
  match '/api/v1/reports/:report_id', to: 'reports#destroy', via: [:delete, :options]

  match '/api/v1/reports/:report_id/comments', to: 'comments#index', via: [:get, :options]
  match '/api/v1/reports/:report_id/comments', to: 'comments#create', via: [:post, :options]
  match '/api/v1/reports/:report_id/comments/:comment_id', to: 'comments#update', via: [:put, :options]
  match '/api/v1/reports/:report_id/comments/:comment_id', to: 'comments#destroy', via: [:delete, :options]

  match '/api/v1/reports/mapquery', to: 'reports#mapquery', via: [:get, :options]
  match '/api/v1/reports/:report_id', to: 'reports#show', via: [:get, :options]
  match '/api/v1/status', to: 'reports#status', via: [:get, :options]

  # User Auth
  # match '/api/v1/users', to: 'users#create', via: [:post, :options]
  # match '/api/v1/logged_in', to: 'users#logged_in', via: [:get, :options]
  # match '/api/v1/log_in', to: 'users#log_in', via: [:put, :options]
  # match '/api/v1/log_out', to: 'users#log_out', via: [:put, :options]
  match '/api/v1/wags', to: 'users#wags', via: [:get, :options]

  resources :users do
    post :update_coordinates, on: :collection
  end

  # FuzzFeed
  match '/api/v1/articles', to: 'articles#index', via: [:get, :options]
  match '/api/v1/articles/:id', to: 'articles#show', via: [:get, :options]
  match '/api/v1/articles', to: 'articles#create', via: [:post, :options]
  match '/api/v1/articles/:article_id/remarks', to: 'remarks#index', via: [:get, :options]
  match '/api/v1/articles/:article_id/remarks', to: 'remarks#create', via: [:post, :options]
  match '/api/v1/articles/:article_id/remarks/:remark_id', to: 'remarks#update', via: [:put, :options]
  match '/api/v1/articles/:article_id/remarks/:remark_id', to: 'remarks#destroy', via: [:delete, :options]

end
