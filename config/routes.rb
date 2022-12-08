Rails.application.routes.draw do
  devise_for :users

  resources :app_notifications
  
  resources :projects

  resources :response_umux_lites
  resources :response_umuxes
  resources :response_sus
  resources :response_attrak_diffs
  resources :response_attrak_diff_abridgeds
  resources :response_deeps

  get 'admin', to: 'admin#index', as: 'admin'
  get 'admin/index'
  get 'admin/project/:id', to: 'admin#project', as: 'admin_project'

  get 'welcome/index'
  get 'projects/index'

  get 'projects/:id/close', to: 'projects#close', as: 'close_project'
  get 'projects/:id/open', to: 'projects#open', as: 'open_project'

  get 'response_sus/recover/:id', to: 'response_sus#recover', as: 'recover_response_sus'
  get 'response_attrak_diffs/recover/:id', to: 'response_attrak_diffs#recover', as: 'recover_response_attrak_diffs'
  get 'response_attrak_diff_abridgeds/recover/:id', to: 'response_attrak_diff_abridgeds#recover', as: 'recover_response_attrak_diff_abridgeds'
  get 'response_deeps/recover/:id', to: 'response_deeps#recover', as: 'recover_response_deeps'
  get 'response_umuxes/recover/:id', to: 'response_umuxes#recover', as: 'recover_response_umuxes'
  get 'response_umux_lites/recover/:id', to: 'response_umux_lites#recover', as: 'recover_response_umux_lites'

  get 'app_notifications/mark_as_read/:id', to: 'app_notifications#mark_as_read', as: 'mark_notification_as_read'

  get 'sample_sizes/usability_problems'
  get 'timer/index'

  get 'r/success/:locale', to: 'projects#response_saved', as: 'project_public_response_saved'
  get 'r/:uri_token', to: 'projects#respond', as: 'project_public_respond'

  root 'projects#index'
end
