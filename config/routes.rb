Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/session/create' => 'users#session_create'

  post '/jobs/pending' => 'users#pending_jobs'

  post '/jobs/pending_job_details' => 'users#pending_job_details'

  post '/jobs/invitedJobs' => 'users#invitedJobs'
  post '/users/searchUsers' => 'users#searchUsers'

  post '/jobs/invitedJobsUserProfile' => 'users#invitedJobsUserProfile'

  post '/users/like' => 'users#like'
  post '/users/unlike' => 'users#unlike'

  resources :users, only: [:create] do
    collection do
      post 'forgot_password'
      post 'change_password'
    end
  end

end
