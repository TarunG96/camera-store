# frozen_string_literal: true

# CategoriesController
class Api::V1::CategoriesController < ActionController::API
  before_action :load_category, only: :category_products

  def index
    render json: {categories: ActiveModelSerializers::SerializableResource.new(Category.all, each_serializer: CategorySerializer), status: 200}
  end

  def create
    category = Category.new category_params
    if category.save
      render json: {category: CategorySerializer.new(category,root: false), status: 200, message: 'Saved Successfully'}
    else
      render json: {category: nil, status: 200, message: 'Errors in saving category', error: category.errors.messages}
    end
  end

  def category_products
    if @category.products.any?
      render json: {products: ActiveModelSerializers::SerializableResource.new(@category.products, each_serializer: ProductSerializer), status: 200}
    else
      render json: {products: [], status: 404, message: "No products found for #{@category.name}"}
    end
  end

  private
    def category_params
      params.require(:category).permit(:name, :category_type, :model)
    end

    def load_category
      if !Category.exists?(id: params[:id])
        render json: {status: 404, message: 'Category not found'}
      else
        @category = Category.find_by(id: params[:id])
      end
    end

end
