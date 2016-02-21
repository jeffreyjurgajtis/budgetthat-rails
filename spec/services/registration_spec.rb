require "rails_helper"

describe Registration do
  describe "save" do
    context "success" do
      let(:user_attributes) do
        {
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      end

      it "returns true" do
        registration = Registration.new(user_attributes: user_attributes)

        expect(registration.save).to eq true
      end

      it "creates a user" do
        registration = Registration.new(user_attributes: user_attributes)

        expect do
          registration.save
        end.to change { User.count }.by(1)
      end

      it "creates an example budget sheet" do
        registration = Registration.new(user_attributes: user_attributes)

        expect do
          registration.save
        end.to change { BudgetSheet.count }.by(1)
      end

      it "creates categories" do
        registration = Registration.new(user_attributes: user_attributes)

        expect do
          registration.save
        end.to change { Category.count }.by(3)
      end
    end

    context "failure" do
      let(:user_attributes) do
        {
          email: "user@example.com",
          password: "password",
          password_confirmation: "mismatch"
        }
      end

      it "returns false" do
        registration = Registration.new(user_attributes: user_attributes)

        expect(registration.save).to eq false
      end

      it "does not create a user" do
        registration = Registration.new(user_attributes: user_attributes)

        expect do
          registration.save
        end.to_not change { User.count }
      end

      it "does not creates a budget sheet" do
        registration = Registration.new(user_attributes: user_attributes)

        expect do
          registration.save
        end.to_not change { BudgetSheet.count }
      end

      it "does not create categories" do
        registration = Registration.new(user_attributes: user_attributes)

        expect do
          registration.save
        end.to_not change { Category.count }
      end
    end
  end

  describe "error_message" do
    it "includes only user attribute validation errors" do
      user_attributes = {
        email: "user@example.com",
        password: "password",
        password_confirmation: "mismatch"
      }
      registration = Registration.new(user_attributes: user_attributes)
      registration.save

      expect(registration.error_message).to eq(
        "Password confirmation doesn't match Password"
      )
    end
  end

  describe "user" do
    it "returns User instance" do
      user_attributes = { email: "user@example.com", password: "password" }
      registration = Registration.new(user_attributes: user_attributes)

      expect(registration.user).to be_a(User)
    end
  end
end
