class EntryHistory
  def initialize(budget_sheet_id:)
    @budget_sheet_id = budget_sheet_id
  end

  def generate
    entries.each_with_object({}) do |(amount, description, occurred_on), acc|
      acc[amount] ||= []
      acc[amount] << { description: description, occurred_on: occurred_on }
    end
  end

  private

  attr_reader :budget_sheet_id

  def entries
    Entry
      .where(budget_sheet_id: budget_sheet_id)
      .pluck(:amount, :description, :occurred_on)
  end
end
