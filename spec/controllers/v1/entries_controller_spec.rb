require "rails_helper"

describe V1::EntriesController, type: :controller do
  let(:user) { create :user }
  let(:budget_sheet) { create :budget_sheet, user: user }
  let(:category) { create :category, budget_sheet: budget_sheet }

  describe "POST create" do
    before { set_access_token_header user.session_api_key.access_token }

    context "success" do
      let(:valid_params) do
        {
          description: "Local Coffee",
          occurred_on: Time.zone.tomorrow,
          amount: 12.12
        }
      end

      it "returns status 201" do
        post :create, category_id: category.id, entry: valid_params
        expect(response).to have_http_status 201
      end

      it "persists" do
        expect do
          post :create, category_id: category.id, entry: valid_params
        end.to change { Entry.count }.by 1
      end
    end

    context "failure" do
      let(:invalid_params) do
        {
          description: "Local Coffee",
        }
      end

      it "returns status 400" do
        post :create, category_id: category.id, entry: invalid_params
        expect(response).to have_http_status 400
      end

      it "persists" do
        expect do
          post :create, category_id: category.id, entry: invalid_params
        end.to_not change { Entry.count }
      end
    end
  end

  describe "PUT update" do
    before { set_access_token_header user.session_api_key.access_token }

    let!(:entry) { create :entry, category: category }

    context "success" do
      let(:valid_params) do
        {
          description: "Local Coffee",
          occurred_on: Time.zone.tomorrow,
          amount: 12.12
        }
      end

      it "returns status 200" do
        put :update, id: entry.id, entry: valid_params
        expect(response).to have_http_status 200
      end
    end

    context "failure" do
      it "returns status 400" do
        put :update, id: entry.id, entry: { amount: "" }
        expect(response).to have_http_status 400
      end
    end
  end

  describe "DELETE destroy" do
    before { set_access_token_header user.session_api_key.access_token }

    let!(:entry) { create :entry, category: category }

    context "success" do
      it "returns status 204" do
        delete :destroy, id: entry.id
        expect(response).to have_http_status 204
      end

      it "deletes" do
        expect do
          delete :destroy, id: entry.id
        end.to change { Entry.count }.by -1
      end
    end
  end
end
