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

  describe "creating" do
    context "when trying to create a supplier with valid data" do
      it "it will be created successfully" do
        expect { create(:supplier) }.to change(Supplier, :count).by(1)
        expect(Supplier.last.name).to be_present
        expect(Supplier.last.cnpj).to be_present
      end
    end
  end

  describe "editing" do
    context "when trying to edit supplier with valid attributes" do
      let(:new_attributes) { attributes_for(:supplier) }

      it "the attributes is changed" do
        supplier.update(new_attributes)
        supplier.reload

        expect(supplier.name).to eq(new_attributes[:name])
        expect(supplier.cnpj).to eq(new_attributes[:cnpj])
      end
    end

    context "when trying to edit supplier with invalid attributes" do
      let(:invalid_attributes) { attributes_for(:supplier, name: "") }

      it "the name is not changed" do
        supplier.update(invalid_attributes)
        supplier.reload

        expect(supplier.changed?).to eq(false)
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

  describe "account_with_digit" do
    context "when supplier have an account" do
      let(:account) { create(:account) }
      let(:supplier) { create(:supplier, account: account) }

      it "return a account number and check digit correctly" do
        expect(supplier.account_with_digit)
          .to eq("#{supplier.account.account_number} - #{supplier.account.check_digit}")
      end
    end

    context "when the supplier does not have an associated account" do
      let(:supplier) { create(:supplier) }

      it "return a account number and check digit correctly" do
        expect(supplier.account_with_digit).to be_nil
      end
    end
  end
end
