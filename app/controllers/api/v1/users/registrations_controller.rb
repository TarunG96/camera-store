module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        result = UserAuthentication.new(params).signup
        render json: {message: result.message, status: result.status, user: result.user}
      end
      
    end
  end
end
