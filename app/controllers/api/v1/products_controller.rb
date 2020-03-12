# frozen_string_literal: true

# ProductsController
class Api::V1::ProductsController < ActionController::API

  def index
    render json: {products: ActiveModelSerializers::SerializableResource.new(Product.all, each_serializer: ProductSerializer), status: 200}
  end

  def create
    product = Product.new product_params
    if product.save
      render json: {product: ProductSerializer.new(product,root: false), status: 200, message: 'Saved Successfully'}
    else
      render json: {product: nil, status: 200, message: 'Errors in saving product', error: product.errors.messages}
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price, :make, :category_id)
    end

end
