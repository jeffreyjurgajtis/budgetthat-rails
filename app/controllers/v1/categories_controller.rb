class V1::CategoriesController < ApplicationController
  def index
    authorize(budget_sheet)

    render json: budget_sheet.categories.created_at_asc
  end

  def create
    budget_sheet = BudgetSheet.find(params[:category][:budget_sheet])
    category = Category.new category_params.merge!(budget_sheet: budget_sheet)

    authorize(category)

    if category.save
      render json: category, status: 201
    else
      render json: { errors: category.errors }, status: 400
    end
  end

  def show
    authorize(category)

    render json: category
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
    params.require(:category).permit(:name, :budget_amount)
  end

  def budget_sheet
    @budget_sheet ||= BudgetSheet.find(params[:budget_sheet_id])
  end
end
