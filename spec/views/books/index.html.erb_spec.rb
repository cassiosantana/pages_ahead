# frozen_string_literal: true

require "rails_helper"

RSpec.describe "books/index", type: :view do
  let(:author) { create(:author) }
  let(:books) { create_list(:book, 5, author: author) }

  before(:each) do
    assign(:books, books)
    render
  end

  it "render the page title" do
    expect_page_title("Books")
  end

  it "render a list of books" do
    books.each do |book|
      expect(rendered).to have_text("Published at: #{book.published_at}", normalize_ws: true)
      expect(rendered).to have_link("Show this book", href: book_path(book))
    end
  end

  it "render a link to new book" do
    expect_link_to_new("book")
  end
end
