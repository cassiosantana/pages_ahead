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

  describe "edit associations with assemblies" do
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

      it "only two were kept" do
        book.assemblies.clear

        assemblies[0..1].each do |assembly|
          book.assemblies << assembly
        end

        expect(book.assemblies.count).to eq(2)
      end
    end
  end

  describe "edit association with author" do
    let(:new_author) { create(:author) }

    context "when trying to change the author" do

      it "the author has been changed" do
        original_author = book.author
        book.author = new_author
        book.save

        expect(book.reload.author).not_to eq(original_author)
      end
    end
  end

  describe "edit attributes" do

    context "when trying to change the publication date" do
      it "the date is changed" do
        previous_date = book.published_at
        book.published_at = previous_date + 1
        book.save

        expect(book.reload.published_at).not_to eq(previous_date)
      end
    end
  end
end
