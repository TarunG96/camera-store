# frozen_string_literal: true

# CategoriesController
class Api::V1::CategoriesController < ActionController::API

  def index
    render json: {categories: Category.all}
  end

  def create
    category = Category.new category_params
    if category.save
      render json: {category: CategorySerializer.new(category,root: false), status: 200, message: 'Saved Successfully'}
    else
      render json: {category: nil, status: 200, message: 'Errors in saving category', error: category.errors.messages}
    end
  end

  private
    def category_params
      params.require(:category).permit(:name, :category_type, :model)
    end

end
