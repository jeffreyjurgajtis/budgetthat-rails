require "rails_helper"

describe V1::BudgetSheetsController do
  let(:user) { create :user }

  describe "GET index" do
    context "success" do
      before do
        set_auth_headers(user)
        create :budget_sheet, user: user
      end

      it "returns status 200" do
        get :index
        expect(response).to have_http_status 200
      end

      it "returns budget sheet JSON" do
        get :index
        expect(json["budget_sheets"]).to be_present
      end
    end

    context "unauthorized" do
      it "returns status 401" do
        get :index
        expect(response).to have_http_status 401
      end
    end
  end

  describe "POST create" do
    before { set_auth_headers(user) }

    context "success" do
      it "returns status 201" do
        post :create, budget_sheet: { name: "Feb" }
        expect(response).to have_http_status 201
      end

      it "persists" do
        expect do
          post :create, budget_sheet: { name: "Feb" }
        end.to change { BudgetSheet.count }.by 1
      end
    end

    context "failure" do
      it "returns status 400" do
        post :create, budget_sheet: { name: "" }
        expect(response).to have_http_status 400
      end

      it "persists" do
        expect do
          post :create, budget_sheet: { name: "" }
        end.to_not change { BudgetSheet.count }
      end
    end
  end

  describe "GET show" do
    before { set_auth_headers(user) }

    context "success" do
      let(:budget_sheet) { create :budget_sheet, user: user }

      it "returns status 200" do
        get :show, id: budget_sheet.id
        expect(response).to have_http_status 200
      end
    end

    context "forbidden" do
      let(:budget_sheet) { create :budget_sheet }

      it "returns status 403" do
        get :show, id: budget_sheet.id
        expect(response).to have_http_status 403
      end
    end
  end

  describe "PUT update" do
    before { set_auth_headers(user) }

    context "success" do
      let(:budget_sheet) { create :budget_sheet, user: user }

      it "returns status 200" do
        put :update, id: budget_sheet.id, budget_sheet: { name: "Feb" }
        expect(response).to have_http_status 200
      end
    end

    context "forbidden" do
      let(:budget_sheet) { create :budget_sheet }

      it "returns status 403" do
        put :update, id: budget_sheet.id, budget_sheet: { name: "Feb" }
        expect(response).to have_http_status 403
      end
    end
  end

  describe "DELETE destroy" do
    before { set_auth_headers(user) }

    context "success" do
      let!(:budget_sheet) { create :budget_sheet, user: user }

      it "returns status 204" do
        delete :destroy, id: budget_sheet.id
        expect(response).to have_http_status 204
      end

      it "deletes" do
        expect do
          delete :destroy, id: budget_sheet.id
        end.to change { BudgetSheet.count }.by -1
      end
    end

    context "forbidden" do
      let!(:budget_sheet) { create :budget_sheet }

      it "returns status 403" do
        delete :destroy, id: budget_sheet.id
        expect(response).to have_http_status 403
      end

      it "does not delete" do
        expect do
          delete :destroy, id: budget_sheet.id
        end.to_not change { BudgetSheet.count }
      end
    end
  end
end

