# frozen_string_literal: true

require "rails_helper"

RSpec.describe Supplier, type: :model do
  let!(:supplier) { create(:supplier) }

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

  describe "destroy" do
    context "when trying to delete an supplier no associated account" do
      it "supplier has been deleted" do
        expect { supplier.destroy }.to change(Supplier, :count).by(-1)
        expect(Supplier.exists?(supplier.id)).to be_falsey
      end

      it "fails to delete the supplier" do
        allow(supplier).to receive(:destroy).and_return(false)

        expect { supplier.destroy }.not_to change(Supplier, :count)
      end
    end

    context "when trying to delete an supplier with associated account" do
      let!(:account) { create(:account, supplier: supplier) }

      it "supplier and your account have been deleted" do
        expect { supplier.destroy }.to change(Supplier, :count).by(-1).and change(Account, :count).by(-1)
      end
    end

    context "when trying to delete a supplier with several parts" do
      let!(:parts) { create_list(:part, 3, supplier: supplier) }

      it "supplier and your parts have been deleted" do
        expect { supplier.destroy }.to change(Supplier, :count).by(-1).and change(Part, :count).by(-3)
        expect(Supplier.exists?(supplier.id)).to be_falsey
        expect(Part.where(id: supplier.parts.pluck(:id))).to be_empty
      end
    end
  end
end
