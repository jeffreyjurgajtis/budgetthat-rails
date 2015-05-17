class V1::EntriesController < ApplicationController
  def create
    entry = Entry.new entry_params

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
    params.require(:entry).permit(
      :description,
      :occurred_on,
      :amount,
      :category_id
    )
  end
end
