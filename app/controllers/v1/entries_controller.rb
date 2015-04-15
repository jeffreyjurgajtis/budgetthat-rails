class V1::EntriesController < ApplicationController

  def create
    entry = category.entries.new entry_params

    if entry.save
      render json: entry, status: 201
    else
      render json: { errors: entry.errors }, status: 400
    end
  end

  def update
    if entry.update entry_params
      render json: entry, status: 200
    else
      render json: { errors: entry.errors }, status: 400
    end
  end

  def destroy
    entry.destroy!
    render nothing: true, status: 204
  end

  private

  def category
    @category ||= Category.find params[:category_id]
  end

  def entry
    @entry ||= Entry.find params[:id]
  end

  def entry_params
    params.require(:entry).permit(:description, :occurred_on, :amount)
  end
end
