# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/books/index", type: :view do
  let(:author) { create(:author) }
  let(:books) { create_list(:book, 5, author:) }

  before(:each) do
    assign(:books, books)
    assign(:q, Book.ransack)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "Books")
  end

  it "render a list of books" do
    books.each do |book|
      expect(rendered).to have_text("Title: #{book.title}", normalize_ws: true)
      expect(rendered).to have_link("Show this book", href: admin_book_path(book))
    end
  end

  it "render a link to new book" do
    expect(rendered).to have_link("New book", href: new_admin_book_path)
  end
end
