# frozen_string_literal: true

require "rails_helper"

RSpec.describe Supplier, type: :model do
  describe "validations" do
    let(:supplier) { build(:supplier) }

    it "is valid with a name" do
      expect(supplier).to be_valid
    end

    it "is invalid without a name" do
      supplier.name = nil
      expect(supplier).to be_invalid
      expect(supplier.errors[:name]).to include("can't be blank")
    end
  end
end
