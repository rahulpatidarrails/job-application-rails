Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/session/create' => 'users#session_create'

  post '/jobs/pending' => 'users#pending_jobs'

  post '/jobs/pending_job_details' => 'users#pending_job_details'

  resources :users, only: [:create] do
    collection do
      post 'forgot_password'
      post 'change_password'
    end
  end

end
