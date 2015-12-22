class V1::BudgetSheetsController < ApplicationController
  before_action :authorize_budget_sheet, only: [:show, :update, :destroy]

  def index
    render json: current_user.budget_sheets.created_at_desc
  end

  def create
    budget_sheet = current_user.budget_sheets.new budget_sheet_params

    if budget_sheet.save
      render json: budget_sheet, status: 201
    else
      render json: { errors: budget_sheet.errors }, status: 400
    end
  end

  def show
    render json: budget_sheet
  end

  def update
    if budget_sheet.update budget_sheet_params
      render json: budget_sheet
    else
      render json: { errors: budget_sheet.errors }, status: 400
    end
  end

  def destroy
    budget_sheet.destroy
    render nothing: true, status: 204
  end

  private

  def budget_sheet
    @budget_sheet ||= BudgetSheet.find(params[:id])
  end

  def budget_sheet_params
    params.require(:budget_sheet).permit(:name, :created_at)
  end

  def authorize_budget_sheet
    authorize budget_sheet
  end
end
