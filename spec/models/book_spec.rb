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
  end
end
