ActionController::Routing::Routes.draw do |map|

  map.resource :user_session
#  map.root :controller => "user_sessions", :action => "new"

  map.resource :account, :controller => "users"
  map.resources :users, :shallow => true do |user|
    user.resource :admin, :controller => "admin_status"
    user.resources :decks
  end

  map.resources :issues

  map.resources :categories

  map.resources :lemmata do |lemma|

    lemma.resources :examples, :requirements => { :context_type => 'lemma' },
                               :collection => { :sort => :post }

    lemma.resources :valencies, :collection => { :sort => :post }
    lemma.resources :collocations, :collection => { :sort => :post }
    lemma.resources :phraseologisms, :collection => { :sort => :post }
  end

  map.resources :examples

  map.resources :valencies do |valency|
    valency.resources :examples, :requirements => { :context_type => 'valency' },
                                 :collection => { :sort => :post }
  end

  map.resources :collocations do |collocation|
    collocation.resources :examples, :requirements => { :context_type => 'collocation' },
                                     :collection => { :sort => :post }
  end

  map.resources :phraseologisms do |phraseologism|
    phraseologism.resources :examples, :requirements => { :context_type => 'phraseologism' },
                                       :collection => { :sort => :post }
  end

  Jammit::Routes.draw(map)

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "categories"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
