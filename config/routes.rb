class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  constraints(SubdomainPresent) do
    root 'homepages#dashboard', as: :subdomain_root
    devise_for :users
    resources :users, only: :index
    resources :projects, except: [:show, :destroy] do
      resources :tasks, except: [:index], controller: 'projects/tasks'
    end
    resources :invoices do
      resources :items, except: [:index], controller: 'invoices/items'
    end
    resources :invoice_imports
    resources :customers
    resources :accounts, only: [:show, :edit, :update, :destroy]
    get '/clear-invoice-params', to: 'invoices#clear_invoice_params', via: [:destroy], as: :clear_invoice_params

  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  constraints(SubdomainBlank) do
    root 'homepages#landing_page'
    #get 'homepages#about'
    #get 'homepages#contact'
    #get 'homepages#faq'
    resources :accounts, only: [:new, :create, :subdomain, :subdomain_check] do
      collection do
        get 'subdomain'
        post 'subdomain_check'
      end
    end

    resources :contacts, only: [:new, :create]
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
