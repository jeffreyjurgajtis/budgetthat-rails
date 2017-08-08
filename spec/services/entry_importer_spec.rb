require "rails_helper"

describe EntryImporter do
  describe "save" do
    let(:budget_sheet) { create(:budget_sheet) }

    context "success" do
      it "returns true on success" do
        csv = EntryCSV.new(data: entry_data)
        service = EntryImporter.new(budget_sheet: budget_sheet, csv: csv)

        expect(service.save).to eq(true)
      end

      it "persists entry records" do
        expect do
          csv = EntryCSV.new(data: entry_data)
          service = EntryImporter.new(budget_sheet: budget_sheet, csv: csv)

          service.save
        end.to change { budget_sheet.entries.count }.by(11)
      end
    end

    context "failure" do
      it "returns false when csv is invalid" do
        csv = EntryCSV.new(data: 999)
        service = EntryImporter.new(budget_sheet: budget_sheet, csv: csv)

        expect(service.save).to eq(false)
      end

      it "does not persist entry records" do
        expect do
          csv = EntryCSV.new(data: 999)
          service = EntryImporter.new(budget_sheet: budget_sheet, csv: csv)
          service.save
        end.to_not change { budget_sheet.entries.count }
      end
    end
  end

  def entry_data
    "\"Post Date\",\"Amount\",\"Check Number\",\"Payee\",\"Memo\"\n\"08/01/2017\",\"-4.32\",\"\",\"FREDDYS FROZEN 310 N I-35 ST SAN MARCOS TX US\",\"\"\n\"08/01/2017\",\"81.07\",\"\",\"SQC*Mary MillageSan FranciscoCAUS\",\"\"\n\"08/01/2017\",\"-35.83\",\"\",\"TARGET T-2429 135 Creekside WayNew BraunfelsTXUS\",\"\"\n\"08/02/2017\",\"-65.69\",\"\",\"OTC BRANDS,  IN 4206 S 108TH STREET OMAHA NE\",\"\"\n\"08/02/2017\",\"-46.7\",\"\",\"HEB #694 2965 IH 35 NORTHNEW BRAUNFELSTXUS\",\"\"\n\"08/03/2017\",\"28.28\",\"\",\"SQC*Gregory JurgajtisSan FranciscoCAUS\",\"\"\n\"08/03/2017\",\"-2491.61\",\"\",\"FREEDOM 0607 - MTG PYMTS\",\"\"\n\"08/03/2017\",\"-60.21\",\"\",\"VERIZON WIRELESS  - PAYMENTS\",\"\"\n\"08/04/2017\",\"-65\",\"\",\"SQ *RENEW U 315 CREEKSIDE WAY NEW BRAUNFELS T\",\"\"\n\"08/04/2017\",\"-162.95\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-33.98\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-6.69\",\"\",\"HOBBYLOBBY 360 CREEKSIDE WAYNEW BRAUNFELSTXUS\",\"\"\n\"08/05/2017\",\"-6.26\",\"\",\"BUC-EE'S #22 2760 IH 35 N NEW BRAUNFELS TX US\",\"\"\n"
  end
end
