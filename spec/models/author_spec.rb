# frozen_string_literal: true

require "rails_helper"

RSpec.describe Author, type: :model do
  let!(:author) { create(:author) }

  describe "validations" do

    context "when name is present" do

      it "author is created" do
        expect(author).to be_valid
      end
    end

    context "when name is not present" do
      let(:author) { build(:author, name: nil) }

      it "author is not created" do
        expect(author).to be_invalid
        expect(author.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe "editing" do
    context "when updating the name" do
      it "updates the name correctly" do

        expect do
          author.name = "another full name"
          author.save
          author.reload
        end.to change { author.name }.to("another full name")
      end

      it "does not allow an empty name" do

        author.name = nil
        author.save
        expect(author.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe "destroy" do
    context "when trying to delete an author no associated books" do
      it "author has been deleted" do
        expect { author.destroy }.to change(Author, :count).by(-1)
      end
    end

    context "when trying to delete an author with associated books" do
      let!(:books) { create_list(:book, 3, author: author) }

      it "deletes the author and associated books" do
        expect { author.destroy }.to change(Author, :count).by(-1).and change(Book, :count).by(-3)
        expect(Author.exists?(author.id)).to be_falsey
        expect(Book.where(id: books.pluck(:id))).to be_empty
      end
    end
  end
end
