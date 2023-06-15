# frozen_string_literal: true

require "rails_helper"

RSpec.describe Part, type: :model do
  describe "validations" do
    let(:supplier) { create(:supplier) }
    let(:parts) { build_list(:part, 3, supplier_id: supplier.id) }

    context "when part_number is present" do
      it "parts creation is valid" do
        parts.each { |part| expect(part).to be_valid }
      end
    end

    context "when part_number is NOT present" do
      it "parts creation is invalid" do
        parts.each do |part|
          part.part_number = nil
          expect(part).to be_invalid
        end
      end
    end

    context "when supplier is NOT present" do
      let(:part) { build(:part, supplier_id: nil) }

      it "part creation is invalid" do
        expect(part).to be_invalid
      end
    end

    context "when adding multiple assemblies" do
      let(:assemblies) { create_list(:assembly, 5) }
      let(:part) { create(:part, supplier_id: supplier.id) }

      it "part creation is valid" do
        assemblies.each do |assembly|
          part.assemblies << assembly
          expect(part).to be_valid
        end
        expect(part.assemblies.count).to eq(5)
      end
    end
  end
end
