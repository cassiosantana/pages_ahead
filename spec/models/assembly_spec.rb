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
    context "when adding multiple parts" do
      let(:supplier) { create(:supplier) }
      let(:parts) { create_list(:part, 3, supplier_id: supplier.id) }
      let(:assembly) { create(:assembly) }

      it "assembly creation is valid" do
        parts.each do |part|
          assembly.parts << part
          expect(assembly).to be_valid
        end
        expect(assembly.parts.count).to eq(3)
      end
    end
  end
end
