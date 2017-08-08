require "rails_helper"

describe EntryCSV do
  describe "#valid?" do
    it "returns true on success" do
      service = EntryCSV.new(data: valid_file_data)
      expect(service.valid?).to eq(true)
    end

    it "returns false when headers are missing" do
      service = EntryCSV.new(data: file_data_with_missing_occurred_on_header)
      expect(service.valid?).to eq(false)
    end

    it "returns false when data is invalid" do
      service = EntryCSV.new(data: 123)
      expect(service.valid?).to eq(false)
    end
  end

  describe "#error_messages" do
    it "is empty when csv is valid" do
      service = EntryCSV.new(data: valid_file_data)
      service.valid?
      expect(service.error_messages).to be_empty
    end

    it "is present when header(s) are missing" do
      service = EntryCSV.new(data: file_data_with_missing_occurred_on_header)
      service.valid?
      expect(service.error_messages).to include("Unable to identify date column in CSV")
    end

    it "is present when data cannot be read" do
      service = EntryCSV.new(data: 123)
      service.valid?
      expect(service.error_messages.first).to include("CSV read error")
    end
  end

  describe "#each" do
    it "allow a block to be passed" do
      expect do
        service = EntryCSV.new(data: valid_file_data)
        service.each do |row|
          expect(row).to be_a(CSV::Row)
        end
      end.to_not raise_error
    end

    it "raises an error if data is unreadable" do
      expect do
        service = EntryCSV.new(data: file_data_with_missing_occurred_on_header)
        service.each
      end.to raise_error
    end
  end

  def valid_file_data
    "\"Post Date\",\"Amount\",\"Check Number\",\"Payee\",\"Memo\"\n\"08/01/2017\",\"-4.32\",\"\",\"FREDDYS FROZEN 310 N I-35 ST SAN MARCOS TX US\",\"\"\n\"08/01/2017\",\"81.07\",\"\",\"SQC*Mary MillageSan FranciscoCAUS\",\"\"\n\"08/01/2017\",\"-35.83\",\"\",\"TARGET T-2429 135 Creekside WayNew BraunfelsTXUS\",\"\"\n\"08/02/2017\",\"-65.69\",\"\",\"OTC BRANDS,  IN 4206 S 108TH STREET OMAHA NE\",\"\"\n\"08/02/2017\",\"-46.7\",\"\",\"HEB #694 2965 IH 35 NORTHNEW BRAUNFELSTXUS\",\"\"\n\"08/03/2017\",\"28.28\",\"\",\"SQC*Gregory JurgajtisSan FranciscoCAUS\",\"\"\n\"08/03/2017\",\"-2491.61\",\"\",\"FREEDOM 0607 - MTG PYMTS\",\"\"\n\"08/03/2017\",\"-60.21\",\"\",\"VERIZON WIRELESS  - PAYMENTS\",\"\"\n\"08/04/2017\",\"-65\",\"\",\"SQ *RENEW U 315 CREEKSIDE WAY NEW BRAUNFELS T\",\"\"\n\"08/04/2017\",\"-162.95\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-33.98\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-6.69\",\"\",\"HOBBYLOBBY 360 CREEKSIDE WAYNEW BRAUNFELSTXUS\",\"\"\n\"08/05/2017\",\"-6.26\",\"\",\"BUC-EE'S #22 2760 IH 35 N NEW BRAUNFELS TX US\",\"\"\n"
  end

  def file_data_with_missing_occurred_on_header
    "\"Post Dat\",\"Amount\",\"Check Number\",\"Payee\",\"Memo\"\n\"08/01/2017\",\"-4.32\",\"\",\"FREDDYS FROZEN 310 N I-35 ST SAN MARCOS TX US\",\"\"\n\"08/01/2017\",\"81.07\",\"\",\"SQC*Mary MillageSan FranciscoCAUS\",\"\"\n\"08/01/2017\",\"-35.83\",\"\",\"TARGET T-2429 135 Creekside WayNew BraunfelsTXUS\",\"\"\n\"08/02/2017\",\"-65.69\",\"\",\"OTC BRANDS,  IN 4206 S 108TH STREET OMAHA NE\",\"\"\n\"08/02/2017\",\"-46.7\",\"\",\"HEB #694 2965 IH 35 NORTHNEW BRAUNFELSTXUS\",\"\"\n\"08/03/2017\",\"28.28\",\"\",\"SQC*Gregory JurgajtisSan FranciscoCAUS\",\"\"\n\"08/03/2017\",\"-2491.61\",\"\",\"FREEDOM 0607 - MTG PYMTS\",\"\"\n\"08/03/2017\",\"-60.21\",\"\",\"VERIZON WIRELESS  - PAYMENTS\",\"\"\n\"08/04/2017\",\"-65\",\"\",\"SQ *RENEW U 315 CREEKSIDE WAY NEW BRAUNFELS T\",\"\"\n\"08/04/2017\",\"-162.95\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-33.98\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-6.69\",\"\",\"HOBBYLOBBY 360 CREEKSIDE WAYNEW BRAUNFELSTXUS\",\"\"\n\"08/05/2017\",\"-6.26\",\"\",\"BUC-EE'S #22 2760 IH 35 N NEW BRAUNFELS TX US\",\"\"\n"
  end
end
