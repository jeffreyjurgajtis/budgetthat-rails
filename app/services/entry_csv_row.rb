class EntryCSVRow
  def initialize(amount:, occurred_on:, description:, budget_sheet_id:, history:)
    @amount          = String(amount)
    @occurred_on     = occurred_on
    @description     = description
    @budget_sheet_id = budget_sheet_id
    @history         = history
  end

  def negative?
    amount.include?("-")
  end

  def unique?
    return true if amount_unique?

    history[amount_in_cents].none? do |historic_entry|
      historic_description = historic_entry[:description]
      historic_occurred_on = historic_entry[:occurred_on]

      historic_description == description && occurred_on_duplicate?(historic_occurred_on)
    end
  end

  def to_a
    [ amount_in_cents, occurred_on, description, budget_sheet_id ]
  end

  private

  attr_reader :amount, :occurred_on, :description, :budget_sheet_id, :history

  def amount_in_cents
    (absolute_amount * 100).to_i
  end

  def absolute_amount
    Float(amount).abs
  end

  def amount_unique?
    !history.has_key?(amount_in_cents)
  end

  def occurred_on_duplicate?(historic_occurred_on)
    occurred_on.to_date == historic_occurred_on
  end
end
