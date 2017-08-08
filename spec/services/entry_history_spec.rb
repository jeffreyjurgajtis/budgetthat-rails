require "rails_helper"

describe EntryHistory do
  describe "#generate" do
    let!(:budget_sheet) { create(:budget_sheet) }
    let!(:entry1) do
      create(
        :entry,
        budget_sheet: budget_sheet,
        amount: 300,
        description: "1",
        occurred_on: "12/12/2016"
      )
    end
    let!(:entry2) do
      create(
        :entry,
        budget_sheet: budget_sheet,
        amount: 400,
        description: "2",
        occurred_on: "12/12/2016"
      )
    end
    let!(:entry3) do
      create(
        :entry,
        budget_sheet: budget_sheet,
        amount: 300,
        description: "3",
        occurred_on: "12/12/2016"
      )
    end

    it "returns budget sheet entries grouped by amount" do
      service = EntryHistory.new(budget_sheet_id: budget_sheet.id)

      expect(service.generate).to eq(
        {
          300 => [
            {
              description: entry1.description,
              occurred_on: entry1.occurred_on
            },
            {
              description: entry3.description,
              occurred_on: entry3.occurred_on
            }
          ],
          400 => [
            {
              description: entry2.description,
              occurred_on: entry2.occurred_on
            }
          ]
        }
      )
    end
  end
end
