# frozen_string_literal: true

# ProductsController
class Api::V1::CartsController < ActionController::API
  before_action :authorize_request

  def add_to_cart
    unless @user.cart.present?
      @user.create_cart(saved_products: params[:product_ids])
      render json: {message: 'Cart created', status: 200}
    else
      @user.cart.saved_products = (@user.cart.saved_products << params[:product_ids]).flatten.uniq.map(&:to_i)
      if @user.cart.save
        render json: {message: 'Cart updated', status: 200}
      else
        render json: {message: 'Cart not updated', status: 400, errors: @user.cart.errors.messages}
      end
    end
  end

  def view_cart
    render json: {products: ActiveModelSerializers::SerializableResource.new(Product.where("id in (?)", @user.cart.saved_products.map(&:to_i)), each_serializer: ProductSerializer), message: 'Products in My cart', status: 200}
  end

  private
    def authorize_request
      header = request.headers['Authorization']
      if header == ""
        render json: { message: "Empty token", status: 400 ,data: nil}
      elsif header!=""
        header = header.split(' ').last if header
        begin
          decoded = JWT.decode(header,Rails.application.secrets.secret_key_base,false)
          @user = User.find(decoded.first['user_id'])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: e.message, status: 401 ,data: nil}
        rescue JWT::DecodeError => e
          render json: { message: e.message, status: 500, data: nil }
        end
      end
     end

end
