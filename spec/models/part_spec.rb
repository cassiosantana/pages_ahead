# frozen_string_literal: true

require "rails_helper"

RSpec.describe Part, type: :model do
  let(:supplier) { create(:supplier) }
  let(:parts) { build_list(:part, 3, supplier_id: supplier.id) }
  let(:assemblies) { create_list(:assembly, 5) }
  let(:part) { create(:part, supplier_id: supplier.id) }

  describe "validations" do

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
  end

  describe "associations" do
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

  describe "editing attributes" do
    context "when editing part number" do
      it "part number is modified" do
        original_number = part.part_number
        part.part_number = original_number + 1.to_s
        part.save

        expect(part.reload.part_number).not_to eq(original_number)
      end
    end
  end
end
