class V1::EntriesController < ApplicationController
  def index
    budget_sheet = BudgetSheet.find(params[:budget_sheet_id])

    authorize(budget_sheet)

    render json: budget_sheet.entries.created_at_desc
  end

  def create
    entry = Entry.new(entry_params)

    authorize(entry)

    if entry.save
      render json: entry, status: 201
    else
      render json: { errors: entry.errors }, status: 400
    end
  end

  def update
    authorize(entry)

    if entry.update entry_params
      render json: entry, status: 200
    else
      render json: { errors: entry.errors }, status: 400
    end
  end

  def destroy
    authorize(entry)

    entry.destroy!
    render nothing: true, status: 204
  end

  private

  def entry
    @entry ||= Entry.find params[:id]
  end

  def entry_params
    params
      .require(:entry)
      .permit(:description, :occurred_on, :amount, :created_at)
      .merge!(
        category_id: params[:entry][:category],
        budget_sheet_id: params[:entry][:budget_sheet]
      )
  end
end
