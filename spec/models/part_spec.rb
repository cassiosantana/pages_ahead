# frozen_string_literal: true

require "rails_helper"

RSpec.describe Part, type: :model do
  let(:assemblies) { create_list(:assembly, 5) }

  describe "validations" do
    context "when part_number is present" do
      it "parts creation is valid" do
        expect(create(:part)).to be_valid
      end
    end

    context "when part creation is invalid" do
      let(:part) { build(:part, part_number: nil, supplier_id: nil) }

      it "it is not created and we get the error messages correctly" do
        expect(part).to be_invalid
        expect(part.errors[:part_number]).to eq(["can't be blank"])
        expect(part.errors[:supplier]).to eq(["must exist"])
      end
    end
  end

  describe "associations" do
    let(:part) { create(:part) }

    before do
      assemblies.each do |assembly|
        part.assemblies << assembly
      end
    end

    context "when adding multiple assemblies" do
      it "part has all associations" do
        expect(part.assemblies.count).to eq(5)
      end
    end

    context "when editing associations" do
      it "all associations are removed" do
        part.assemblies.clear
        expect(part.assemblies.count).to eq(0)
      end

      it "only two were kept" do
        part.assemblies.clear

        assemblies[0..1].each do |assembly|
          part.assemblies << assembly
        end

        expect(part.assemblies.count).to eq(2)
      end
    end
  end

  describe "editing" do
    let!(:part) { create(:part) }
    context "when editing attributes with valid params" do
      let(:valid_params) { attributes_for(:part).except(:supplier) }

      it "the part is updated" do
        expect(part.update(valid_params)).to be true
        valid_params.each do |attribute, value|
          expect(part.send(attribute)).to eq(value)
        end
      end
    end

    context "when editing attributes with invalid params" do
      let(:new_supplier) { create(:supplier) }

      it "the part is not updated" do
        expect(part.update(supplier: new_supplier)).to be false
        expect(part.errors.full_messages).to eq(["Supplier cannot be updated"])
      end
    end
  end

  describe "destroy" do
    context "when trying to delete the part that has no associated assemblies" do
      let!(:part) { create(:part) }

      it "the part is deleted" do
        expect { part.destroy }.to change(Part, :count).by(-1).and change(Supplier, :count).by(0)
        expect(Part.exists?(part.id)).to be_falsey
      end
    end

    context "when the part has associated assemblies" do
      let!(:part) { create(:part) }

      it "the part is deleted and the assemblies remain intact" do
        part.assemblies << assemblies
        part.save

        expect { part.destroy }.to change(Part, :count).by(-1).and change(Assembly, :count).by(0)
        expect(Assembly.where(id: assemblies.pluck(:id)).count).to eq(5)
      end
    end
  end
end
