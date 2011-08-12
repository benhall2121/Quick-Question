Todo::Application.routes.draw do
  resources :histories

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :projects
  resources :tasks
  resources :authentications
  root :to => "projects#home"
  get "sendQuestion/:id" => "projects#send_question", :as => "sendQuestion"
  get "updateQuestionHistory/:project_id/:task_id" => "histories#updateQuestionHistory", :as => "updateQuestionHistory"
  get "uqh/:project_id/:task_id" => "histories#updateQuestionHistory", :as => "uqh"
end
