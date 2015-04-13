require "rails_helper"

describe V1::CategoriesController do
  let(:user) { create :user }

  describe "GET index" do
    context "success" do
      let(:budget_sheet) { create :budget_sheet, user: user }

      before do
        set_access_token_header user.session_api_key.access_token
        create :category, budget_sheet: budget_sheet
      end

      it "returns status 200" do
        get :index, budget_sheet_id: budget_sheet.id
        expect(response).to have_http_status 200
      end

      it "returns category JSON" do
        get :index, budget_sheet_id: budget_sheet.id
        expect(json["categories"]).to be_present
      end
    end

    context "forbidden" do
      let(:budget_sheet) { create :budget_sheet }

      it "returns status 403" do
        set_access_token_header user.session_api_key.access_token
        get :index, budget_sheet_id: budget_sheet.id
        expect(response).to have_http_status 403
      end
    end

    context "unauthorized" do
      let(:budget_sheet) { create :budget_sheet }

      it "returns status 401" do
        get :index, budget_sheet_id: budget_sheet.id
        expect(response).to have_http_status 401
      end
    end
  end

  describe "POST create" do
    before { set_access_token_header user.session_api_key.access_token }

    context "success" do
      let(:budget_sheet) { create :budget_sheet, user: user }

      let(:valid_attrs) do
        {
          name: "Coffee House",
          budget_amount: 25.00
        }
      end

      it "returns status 201" do
        post :create, budget_sheet_id: budget_sheet.id, category: valid_attrs
        expect(response).to have_http_status 201
      end

      it "persists" do
        expect do
          post :create, budget_sheet_id: budget_sheet.id, category: valid_attrs
        end.to change { Category.count }.by 1
      end
    end

    context "failure" do
      let(:budget_sheet) { create :budget_sheet, user: user }

      let(:invalid_attrs) do
        {
          name: "",
          budget_amount: 25.00
        }
      end

      it "returns status 400" do
        post :create, budget_sheet_id: budget_sheet.id, category: invalid_attrs
        expect(response).to have_http_status 400
      end

      it "does not persist" do
        expect do
          post :create, budget_sheet_id: budget_sheet.id, category: invalid_attrs
        end.to_not change { Category.count }
      end
    end

    context "forbidden" do
      let(:budget_sheet) { create :budget_sheet }

      it "returns status 403" do
        post :create, budget_sheet_id: budget_sheet.id, category: {}
        expect(response).to have_http_status 403
      end
    end
  end

  describe "PUT update" do
    before { set_access_token_header user.session_api_key.access_token }

    context "success" do
      let(:budget_sheet) { create :budget_sheet, user: user }

      it "returns status 200" do
        category = create :category, budget_sheet: budget_sheet
        put :update, id: category.id, category: { name: "Coffee" }
        expect(response).to have_http_status 200
      end
    end

    context "failure" do
      let(:budget_sheet) { create :budget_sheet, user: user }

      it "returns status 400" do
        category = create :category, budget_sheet: budget_sheet
        put :update, id: category.id, category: { name: "" }
        expect(response).to have_http_status 400
      end
    end

    context "forbidden" do
      let(:budget_sheet) { create :budget_sheet }

      it "returns status 403" do
        category = create :category, budget_sheet: budget_sheet
        put :update, id: category.id, category: { name: "Coffee" }
        expect(response).to have_http_status 403
      end
    end
  end

  describe "DELETE destroy" do
    before { set_access_token_header user.session_api_key.access_token }

    context "success" do
      let(:budget_sheet) { create :budget_sheet, user: user }
      let!(:category) { create :category, budget_sheet: budget_sheet }

      it "returns status 204" do
        delete :destroy, id: category.id
        expect(response).to have_http_status 204
      end

      it "deletes" do
        expect do
          delete :destroy, id: category.id
        end.to change { Category.count }.by -1
      end
    end

    context "forbidden" do
      let(:budget_sheet) { create :budget_sheet }

      it "returns status 403" do
        category = create :category, budget_sheet: budget_sheet
        delete :destroy, id: category.id
        expect(response).to have_http_status 403
      end
    end
  end
end
