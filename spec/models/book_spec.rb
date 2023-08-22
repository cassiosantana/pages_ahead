require "rails_helper"
require "isbn_generator"

RSpec.describe Book, type: :model do
  let(:book) { create(:book) }
  let(:assemblies) { create_list(:assembly, 3) }

  describe "validations and associations" do
    context "when all attributes are valid" do
      it "is valid and can have assemblies associated" do
        book.assemblies << assemblies
        expect(book).to be_valid
        expect(book.assemblies.count).to eq(3)

        book.assemblies.clear
        expect(book.assemblies.count).to eq(0)

        book.assemblies << assemblies[0..1]
        expect(book.assemblies.count).to eq(2)
      end
    end

    context "when all attributes are invalid" do
      it "receive error messages correctly" do
        book.update(published_at: nil, author: nil, isbn: nil)
        expect(book).to be_invalid
        expect(book.errors[:author]).to eq(["must exist"])
        expect(book.errors[:published_at]).to eq(["can't be blank"])
        expect(book.errors[:isbn]).to eq(["can't be blank", "is invalid"])
      end
    end
  end

  describe "updating attributes" do
    it "can have its author, publication date and isbn updated" do
      new_isbn = IsbnGenerator.isbn_thirteen
      new_author = create(:author)

      new_date = book.published_at + 1.day
      book.update(published_at: new_date, isbn: new_isbn, author: new_author)

      expect(book.reload).to have_attributes(
        published_at: new_date,
        isbn: new_isbn,
        author: new_author
      )
    end
  end

  describe "destroying a book" do
    context "when a book has no associated assemblies" do
      it "the book is deleted but not its author" do
        book.assemblies.clear
        expect { book.destroy }.to change(Book, :count).by(-1)
                                                       .and change(Author, :count).by(0)
      end
    end

    context "when a book has associated assemblies" do
      it "the book is deleted but not its assemblies" do
        book.assemblies << assemblies
        expect { book.destroy }.to change(Book, :count).by(-1)
                                                       .and change(Assembly, :count).by(0)
      end
    end
  end
end
