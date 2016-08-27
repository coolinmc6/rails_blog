Rails.application.routes.draw do
  get 'welcome/index'

  #we set the root to welcome#index shortly after creating the controller "Welcome" with the action, "index"
  root 'welcome#index'

  # ~5 -> the resources method allows you to declare a standard REST resource
  resources :articles do
  	resources :comments
  end

  # Rails routing: http://edgeguides.rubyonrails.org/routing.html
end
