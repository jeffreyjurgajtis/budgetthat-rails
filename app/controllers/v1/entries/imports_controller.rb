class V1::Entries::ImportsController < ApplicationController
  def create
    authorize(budget_sheet)

    csv = EntryCSV.new(data: file_data)
    importer = EntryImporter.new(budget_sheet: budget_sheet, csv: csv)

    if importer.save
      entries = ActiveModel::SerializableResource.new(
        importer.entries,
        each_serializer: EntrySerializer
      ).as_json[:entries]

      render(
        json: {
          entry_import: { id: SecureRandom.hex },
          entries: entries
        },
        status: 201
      )
    else
      render json: { errors: importer.error_messages }, status: 422
    end
  end

  private

  def budget_sheet
    @budget_sheet ||= BudgetSheet.find(params[:budget_sheet_id])
  end

  def file_data
    params.fetch(:entry_import).fetch(:file_data, "")
  end
end
