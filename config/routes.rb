Progrules::Application.routes.draw do
  resources :widgets


  # The priority is based upon order of creation:
  # first created -> highest priority.
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  root :to => 'login#index'
  get 'login/new', to: 'login#new'
  get 'login', to: 'login#create'
  post 'login', to: 'login#post'
  delete 'login', to: 'login#destroy'
  get 'user', to: 'user#index'
  get 'user/index', to: 'user#index'
  get 'professor', to: 'professor#index'
  get 'alunos', to: 'aluno#index'
  get 'alunos/new', to: 'aluno#new'
  post 'alunos/new', to: 'aluno#create'
  get 'preferencia', to: 'preferencia#index'
  get 'preferencia/new', to: 'preferencia#new'
  post 'preferencia/new', to: 'preferencia#create'
  get 'alunos/edit/:id', to: 'aluno#edit'
  post 'alunos/edit/:id', to: 'aluno#update'
  delete 'alunos/delete/:id', to: 'aluno#destroy'
  get 'professor/excel', to: 'professor#excel'
  post 'professor/excel', to: 'professor#upload'
  get 'professor/gerador', to: 'professor#gerador'
  post 'professor/gerador', to: 'professor#results'
  get 'preferencia/show', to: 'preferencia#show'






  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
