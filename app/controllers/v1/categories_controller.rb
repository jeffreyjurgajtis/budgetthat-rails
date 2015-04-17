class V1::CategoriesController < ApplicationController
  before_action :authorize_budget_sheet, only: [:index, :create]
  before_action :authorize_category, only: [:update, :destroy]

  def index
    render json: budget_sheet.categories.created_at_asc
  end

  def create
    category = budget_sheet.categories.new category_params

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
    @budget_sheet ||= BudgetSheet.find params[:budget_sheet_id]
  end

  def category
    @category ||= Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :budget_amount
  end

  def authorize_budget_sheet
    authorize budget_sheet
  end

  def authorize_category
    authorize category
  end
end
