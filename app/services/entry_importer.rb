require "csv"

class EntryImporter
  def initialize(budget_sheet:, csv:)
    @budget_sheet   = budget_sheet
    @csv            = csv
    @error_messages = []
    @entries        = []
    @history        = EntryHistory.new(budget_sheet_id: budget_sheet.id).generate
  end

  def save
    return false unless csv_valid?

    entry_rows = extract_entry_rows_from_csv
    return false if error_messages.any?

    import_result = import_entry_rows!(entry_rows)
    @entries = Entry.where(id: import_result.ids)
    csv.close
    true
  end

  attr_reader :entries, :error_messages

  private

  attr_reader :budget_sheet, :csv, :history

  def csv_valid?
    return true if csv.valid?

    @error_messages = csv.error_messages
    false
  end

  def extract_entry_rows_from_csv
    entry_rows = []

    csv.each do |row|
      entry_row = EntryCSVRow.new(
        amount: row[csv.amount_index],
        occurred_on: row[csv.occurred_on_index],
        description: row[csv.description_index],
        budget_sheet_id: budget_sheet.id,
        history: history
      )

      if entry_row.valid?
        entry_rows << entry_row if entry_row.negative? && entry_row.unique?
      else
        error_messages << entry_row.error_message
      end
    end

    entry_rows
  end

  def import_entry_rows!(entry_rows)
    Entry.import(
      %i(amount occurred_on description budget_sheet_id),
      entry_rows.map(&:to_a),
      validate: false
    )
  end
end
