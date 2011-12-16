MyFitness::Application.routes.draw do
  #resources :participant_profiles

  #resources :fitness_goals

  #resources :participants

  resources :participants do
    resources :fitness_goals
    resources :participant_profiles

    collection do
      get 'welcome' #welcome page
      post 'find' #find a participant by email
      get 'list' #list all participants registered in the system
    end

  end
  
  root :to => 'participants#welcome'

end
