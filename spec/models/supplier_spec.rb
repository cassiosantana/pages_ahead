# frozen_string_literal: true

require "rails_helper"

RSpec.describe Supplier, type: :model do
  let(:supplier) { create(:supplier) }
  describe "validations" do

    it "is valid with a name" do
      expect(supplier).to be_valid
    end

    it "is invalid without a name" do
      supplier.name = nil
      expect(supplier).to be_invalid
      expect(supplier.errors[:name]).to include("can't be blank")
    end
  end

  describe "editing" do
    context "when editing supplier name" do
      it "the name is changed" do
        original_name = supplier.name
        supplier.name = "#{original_name} new_name"
        supplier.save

        expect(supplier.reload.name).to_not eq(original_name)
      end

      it "the name is not changed" do
        supplier.name = ""
        supplier.save

        expect(supplier.reload.name).not_to eq("")
      end
    end
  end
end
