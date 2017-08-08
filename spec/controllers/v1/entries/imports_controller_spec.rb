require "rails_helper"

describe V1::Entries::ImportsController, type: :controller do
  let(:user) { create :user }
  let(:budget_sheet) { create :budget_sheet, user: user }

  describe "POST create" do
    context "success" do
      before { set_auth_headers(user) }

      it "returns status 201" do
        post :create, {
          budget_sheet_id: budget_sheet.id,
          entry_import: { file_data: entry_data }
        }

        expect(response).to have_http_status 201
      end

      it "returns entries" do
        post :create, {
          budget_sheet_id: budget_sheet.id,
          entry_import: { file_data: entry_data }
        }

        expect(json["entries"]).to be_an(Array)
      end

      it "returns a meaningless entry_import key/id" do
        post :create, {
          budget_sheet_id: budget_sheet.id,
          entry_import: { file_data: entry_data }
        }

        expect(json["entry_import"]["id"]).to be_present
      end
    end

    context "failure" do
      before { set_auth_headers(user) }

      it "returns status 422" do
        post :create, {
          budget_sheet_id: budget_sheet.id,
          entry_import: { file_data: "invalid" }
        }

        expect(response).to have_http_status 422
      end

      it "returns errors" do
        post :create, {
          budget_sheet_id: budget_sheet.id,
          entry_import: { file_data: "invalid" }
        }

        expect(json["errors"]).to match_array(
          [
            "Unable to identify date column in CSV",
            "Unable to identify amount column in CSV",
            "Unable to identify description column in CSV"
          ]
        )
      end
    end

    context "forbidden" do
      let(:unauthorized_user) { create(:user) }
      before { set_auth_headers(unauthorized_user) }

      it "returns status 403" do
        post :create, {
          budget_sheet_id: budget_sheet.id,
          entry_import: { file_data: entry_data }
        }

        expect(response).to have_http_status 403
      end
    end
  end

  def entry_data
    "\"Post Date\",\"Amount\",\"Check Number\",\"Payee\",\"Memo\"\n\"08/01/2017\",\"-4.32\",\"\",\"FREDDYS FROZEN 310 N I-35 ST SAN MARCOS TX US\",\"\"\n\"08/01/2017\",\"81.07\",\"\",\"SQC*Mary MillageSan FranciscoCAUS\",\"\"\n\"08/01/2017\",\"-35.83\",\"\",\"TARGET T-2429 135 Creekside WayNew BraunfelsTXUS\",\"\"\n\"08/02/2017\",\"-65.69\",\"\",\"OTC BRANDS,  IN 4206 S 108TH STREET OMAHA NE\",\"\"\n\"08/02/2017\",\"-46.7\",\"\",\"HEB #694 2965 IH 35 NORTHNEW BRAUNFELSTXUS\",\"\"\n\"08/03/2017\",\"28.28\",\"\",\"SQC*Gregory JurgajtisSan FranciscoCAUS\",\"\"\n\"08/03/2017\",\"-2491.61\",\"\",\"FREEDOM 0607 - MTG PYMTS\",\"\"\n\"08/03/2017\",\"-60.21\",\"\",\"VERIZON WIRELESS  - PAYMENTS\",\"\"\n\"08/04/2017\",\"-65\",\"\",\"SQ *RENEW U 315 CREEKSIDE WAY NEW BRAUNFELS T\",\"\"\n\"08/04/2017\",\"-162.95\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-33.98\",\"\",\"SQC*MARY MILLAG 1455 MARKET ST 04153753176 CA\",\"\"\n\"08/04/2017\",\"-6.69\",\"\",\"HOBBYLOBBY 360 CREEKSIDE WAYNEW BRAUNFELSTXUS\",\"\"\n\"08/05/2017\",\"-6.26\",\"\",\"BUC-EE'S #22 2760 IH 35 N NEW BRAUNFELS TX US\",\"\"\n"
  end
end
