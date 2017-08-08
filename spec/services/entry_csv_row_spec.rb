require "rails_helper"

describe EntryCSVRow do
  describe "#negative?" do
    it "returns true when amount includes a dash" do
      service = EntryCSVRow.new(
        amount: "-4.32",
        occurred_on: nil,
        description: nil,
        budget_sheet_id: nil,
        history: {}
      )

      expect(service.negative?).to eq(true)
    end

    it "returns false when amount does not include a dash" do
      service = EntryCSVRow.new(
        amount: "4.32",
        occurred_on: nil,
        description: nil,
        budget_sheet_id: nil,
        history: {}
      )

      expect(service.negative?).to eq(false)
    end
  end

  describe "#unique?" do
    it "returns true when no other entry amounts are the same" do
      history = {
        100 => [
          { description: "Gas Station", occurred_on: Time.zone.today }
        ]
      }

      service = EntryCSVRow.new(
        amount: "4.32",
        occurred_on: nil,
        description: nil,
        budget_sheet_id: nil,
        history: history
      )

      expect(service.unique?).to eq(true)
    end

    it "returns true when amount, description are the same and occurred_on is not" do
      history = {
        432 => [
          { description: "Gas Station", occurred_on: Time.zone.yesterday }
        ]
      }

      service = EntryCSVRow.new(
        amount: "4.32",
        occurred_on: Time.zone.today,
        description: "Gas Station",
        budget_sheet_id: nil,
        history: history
      )

      expect(service.unique?).to eq(true)
    end

    it "returns false when amount, description, and occurred_on are the same" do
      history = {
        432 => [
          { description: "Gas Station", occurred_on: Time.zone.yesterday }
        ]
      }

      service = EntryCSVRow.new(
        amount: "4.32",
        occurred_on: Time.zone.yesterday,
        description: "Gas Station",
        budget_sheet_id: nil,
        history: history
      )

      expect(service.unique?).to eq(false)
    end
  end
end
