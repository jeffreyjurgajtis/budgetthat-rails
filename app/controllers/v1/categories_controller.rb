class V1::CategoriesController < ApplicationController
  before_action :ensure_budget_sheet_belongs_to_user

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

  private

  def budget_sheet
    @budget_sheet ||= BudgetSheet.find params[:budget_sheet_id]
  end

  def category_params
    params.require(:category).permit :name, :budget_amount
  end

  def ensure_budget_sheet_belongs_to_user
    head 403 unless budget_sheet.user_id == current_user.id
  end
end
