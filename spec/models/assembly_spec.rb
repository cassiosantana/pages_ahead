# frozen_string_literal: true

require "rails_helper"

RSpec.describe Assembly, type: :model do
  describe "validations" do
    let(:assembly) { build(:assembly) }

    context "when name is present" do
      it "assembly creation is valid" do
        expect(assembly).to be_valid
      end
    end

    context "when name is not present" do
      let(:assembly) { build(:assembly, name: nil) }

      it "assembly creation is invalid" do
        expect(assembly).to be_invalid
      end
    end
  end

  describe "associations" do
    let(:supplier) { create(:supplier) }
    let(:parts) { create_list(:part, 3, supplier_id: supplier.id) }
    let(:assembly) { create(:assembly) }

    before do
      parts.each do |part|
        assembly.parts << part
      end
    end

    context "when adding multiple parts" do
      it "assembly has all associations" do
        expect(assembly.parts.count).to eq(3)
      end
    end

    context "when editing associations" do

      it "all associations are removed" do
        assembly.parts.clear
        expect(assembly.parts.count).to eq(0)
      end

      it "only two were kept" do
        assembly.parts.clear

        parts[0..1].each do |part|
          assembly.parts << part
        end

        expect(assembly.parts.count).to eq(2)
      end
    end
  end
end
