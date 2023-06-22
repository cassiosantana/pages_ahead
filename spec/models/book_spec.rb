# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:author) { create(:author) }
  let(:book) { create(:book, author_id: author.id) }

  describe "validations" do

    context "when publication date is present" do

      it "book creation is valid" do
        expect(book).to be_valid
      end
    end

    context "when publication date is NOT present" do
      let(:book) { build(:book, author_id: author.id, published_at: nil) }

      it "book creation is invalid" do
        expect(book).to be_invalid
      end
    end

    context "when author is NOT present" do
      let(:book) { build(:book, author_id: nil) }

      it "book creation is invalid" do
        expect(book).to be_invalid
      end
    end
  end

  describe "associations with assemblies" do
    let(:assemblies) { create_list(:assembly, 3) }

    before do
      assemblies.each do |assembly|
        book.assemblies << assembly
      end
    end

    context "when adding multiple assemblies" do
      it "book has all associations" do
        expect(book.assemblies.count).to eq(3)
      end
    end

    context "when editing associations" do
      it "all associations are removed" do
        book.assemblies.clear
        expect(book.assemblies.count).to eq(0)
      end
    end
  end
end
