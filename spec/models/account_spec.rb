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

      it "requires account_number to be valid" do
        expect(account).to be_invalid
      end
    end

    context "when the supplier tries to create two accounts" do
      let(:account) { create(:account, supplier_id: supplier.id) }

      it "creation of the second account is not valid" do
        expect(account).to be_invalid
        expect(account.errors[:supplier]).to include("already has an associated account")
      end
    end
  end
end
