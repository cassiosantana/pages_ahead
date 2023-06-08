# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    let(:author) { create(:author) }

    context "when publication date is present" do
      let(:book) { build(:book, author_id: author.id) }

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
end
