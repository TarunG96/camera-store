Rails.application.routes.draw do
  mount Apidoco::Engine, at: "/docs"
  namespace 'api' do
    namespace "v1" do
      devise_for :users, controllers: {
        sessions: "api/v1/users/sessions",
        registrations: "api/v1/users/registrations"
      }
      devise_scope :user do
        resources :carts do
          collection do
            get :view_cart
            post :add_to_cart
            post :remove_from_cart
          end
        end
      end

      resources :categories do
        member do
          get :category_products
        end
      end

      resources :products
    end
  end
end
