# frozen_string_literal: true

require "rails_helper"

RSpec.describe Author, type: :model do
  let!(:author) { create(:author) }

  describe "create" do
    context "when name and cpf is present" do
      it "author is created" do
        expect(author).to be_valid
      end
    end

    context "when name and cpf is not present" do
      let(:author) { build(:author, name: nil, cpf: nil) }

      it "author is not created" do
        expect(author).to be_invalid
        expect(author.errors[:name]).to eq(["can't be blank"])
        expect(author.errors[:cpf]).to eq(["can't be blank", "is invalid"])
      end
    end
  end

  describe "edit" do
    context "when updating attributes" do
      let(:attributes) { attributes_for(:author) }

      it "updates attributes correctly" do
        expect do
          author.update(attributes)
          author.reload
        end.to change { [author.name, author.cpf] }.to([attributes[:name], attributes[:cpf]])
      end

      it "does not update and receive error messages correctly" do
        author.update(name: nil, cpf: nil)

        expect(author).to be_invalid
        expect(author.errors[:name]).to eq(["can't be blank"])
        expect(author.errors[:cpf]).to eq(["can't be blank", "is invalid"])
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
