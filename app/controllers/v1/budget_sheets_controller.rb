class V1::BudgetSheetsController < ApplicationController
  before_action :ensure_budget_sheet_belongs_to_user, only: [:show, :destroy]

  def index
    render json: current_user.budget_sheets.created_at_asc
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

  def destroy
    budget_sheet.destroy
    render nothing: true, status: 204
  end

  private

  def budget_sheet
    @budget_sheet ||= BudgetSheet.find params[:id]
  end

  def budget_sheet_params
    params.require(:budget_sheet).permit :name
  end

  def ensure_budget_sheet_belongs_to_user
    head 403 unless budget_sheet.user_id == current_user.id
  end
end
