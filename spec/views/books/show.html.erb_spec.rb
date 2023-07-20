# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/show', type: :view do
  let(:assemblies) { create_list(:assembly, 3) }
  let(:author) { create(:author) }
  let(:book) { create(:book, author: author, assemblies: assemblies) }

  before(:each) do
    assign(:book, book)
    render
  end

  context "rendering of book attributes" do
    it "render the publication date" do
      expect(rendered).to have_text(book.published_at)
    end

    it "render the author name" do
      expect(rendered).to have_text(book.author.name)
    end

    it "render the book's assemblies" do
      expect(rendered).to have_selector("p strong", text: "Assemblies:")
      book.assemblies.each do |assembly|
        expect(rendered).to have_selector("ul li", text: assembly.name)
      end
    end
  end

  context "rendering links and button" do
    it "render the link to edit book" do
      expect_link_to_edit(book)
    end

    it "render the link to all books" do
      expect_link_back_to("books")
    end

    it "render the button to destroy book" do
      expect_submit_button("Destroy this book")
    end
  end
end
