# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account, type: :model do
  describe "validations" do
    let(:supplier) { create(:supplier) }

    context "when account_number is present" do
      let(:account) { build(:account, supplier_id: supplier.id) }

      it "requires account_number to be valid" do
        expect(account).to be_valid
      end
    end

    context "when account_number is NOT present" do
      let(:account) { build(:account, supplier_id: supplier.id, account_number: nil) }

      it "without account number the creation is not valid" do
        expect(account).to be_invalid
        expect(account.errors[:account_number]).to include("can't be blank")
      end
    end

    context "when the supplier tries to create two accounts" do
      let!(:existing_account) { create(:account, supplier_id: supplier.id) }
      let(:second_account) { build(:account, supplier_id: supplier.id) }

      it "creation of the second account is not valid" do
        expect(second_account).to be_invalid
        expect(second_account.errors[:supplier_id]).to include("already has an associated account")
      end
    end

    context "when the supplier tries to create two accounts" do
      let!(:account) { create(:account, supplier: supplier) }
      let(:second_account) { build(:account, supplier: supplier) }

      it "is not valid" do
        expect(second_account).to be_invalid
        expect(second_account.errors[:supplier_id]).to include("already has an associated account")
      end
    end
  end

  describe "editing" do
    let!(:supplier) { create(:supplier) }

    context "when attempting to update account_number" do
      let!(:account) { create(:account, supplier: supplier) }

      it "does not change the account_number" do
        original_account_number = account.account_number
        account.account_number = "new_account_number"
        account.save

        expect(account.reload.account_number).to eq(original_account_number)
      end
    end
  end
end
