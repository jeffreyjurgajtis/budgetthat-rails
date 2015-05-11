class V1::CategoriesController < ApplicationController
  before_action :authorize_budget_sheet, only: [:create]
  before_action :authorize_category, only: [:update, :destroy]

  def create
    category = Category.new category_params

    if category.save
      render json: category, status: 201
    else
      render json: { errors: category.errors }, status: 400
    end
  end

  def update
    if category.update category_params
      render json: category
    else
      render json: { errors: category.errors }, status: 400
    end
  end

  def destroy
    category.destroy
    render nothing: true, status: 204
  end

  private

  def budget_sheet
    @budget_sheet ||= BudgetSheet.where(id: budget_sheet_id).first_or_initialize
  end

  def category
    @category ||= Category.find params[:id]
  end

  def category_params
    params.require(:category).permit(:name, :budget_amount, :budget_sheet_id)
  end

  def budget_sheet_id
    params.require(:category)[:budget_sheet_id]
  end

  def authorize_budget_sheet
    authorize budget_sheet
  end

  def authorize_category
    authorize category
  end
end
