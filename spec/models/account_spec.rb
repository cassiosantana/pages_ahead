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
  end
end
