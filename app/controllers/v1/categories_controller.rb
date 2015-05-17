class V1::CategoriesController < ApplicationController
  def create
    category = Category.new category_params

    authorize(category)

    if category.save
      render json: category, status: 201
    else
      render json: { errors: category.errors }, status: 400
    end
  end

  def update
    authorize(category)

    if category.update category_params
      render json: category
    else
      render json: { errors: category.errors }, status: 400
    end
  end

  def destroy
    authorize(category)

    category.destroy
    render nothing: true, status: 204
  end

  private

  def category
    @category ||= Category.find params[:id]
  end

  def category_params
    params.require(:category).permit(:name, :budget_amount, :budget_sheet_id)
  end
end
