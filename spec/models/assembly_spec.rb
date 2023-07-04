# frozen_string_literal: true

require "rails_helper"

RSpec.describe Assembly, type: :model do
  let!(:assembly) { create(:assembly) }
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier_id: supplier.id) }
  let(:author) { create(:author) }
  let(:books) { create_list(:book, 5, author_id: author.id) }

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
    context "when adding multiple parts" do
      it "assembly has all associations" do
        assembly.parts << parts
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
        assembly.parts << parts.take(2)

        expect(assembly.parts.count).to eq(2)
      end
    end
  end

  describe "editing associations with books" do
    context "when adding multiple books" do
      it "assembly has all associations" do
        assembly.books << books
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
        assembly.books << books.take(2)

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

  describe "destroy" do
    context "when the assembly has no associations" do
      it "the assembly is deleted" do
        expect { assembly.destroy }.to change(Assembly, :count).by(-1)
        expect(Assembly.exists?(assembly.id)).to be_falsey
      end
    end
  end
end
