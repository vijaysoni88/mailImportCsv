Rails.application.routes.draw do
  root 'attachment#index'
  get 'attachment/index'
  post 'attachment/import'
end
