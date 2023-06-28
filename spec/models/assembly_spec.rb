# frozen_string_literal: true

require "rails_helper"

RSpec.describe Assembly, type: :model do
  let(:assembly) { create(:assembly) }

  describe "validations" do

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

  describe "editing associations with parts" do
    let(:supplier) { create(:supplier) }
    let(:parts) { create_list(:part, 3, supplier_id: supplier.id) }

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

  describe "editing associations with books" do
    let(:author) { create(:author) }
    let(:books) { create_list(:book, 5, author_id: author.id) }

    before do
      books.each do |book|
        assembly.books << book
      end
    end

    context "when adding multiple books" do
      it "assembly has all associations" do
        expect(assembly.books.count).to eq(5)
      end
    end

    context "when editing associations" do
      it "all associations are removed" do
        assembly.books.clear
        expect(assembly.books.count).to eq(0)
      end
    end

    context "when editing associations" do
      it "only two were kept" do
        assembly.books.clear

        books[0..1].each do |book|
          assembly.books << book
        end
        expect(assembly.books.count).to eq(2)
      end
    end
  end

  describe "editing attributes" do
    context "when attempting to update assembly name" do
      it "the assembly name is modified" do
        original_name = assembly.name
        assembly.name = "new assembly name"
        assembly.save

        expect(assembly.reload.name).not_to eq(original_name)
      end
    end
  end
end
