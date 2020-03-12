Rails.application.routes.draw do
  namespace 'api' do
    namespace "v1" do
      devise_for :users, controllers: {
        sessions: "api/v1/users/sessions",
        registrations: "api/v1/users/registrations"
      }
      devise_scope :user do
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
