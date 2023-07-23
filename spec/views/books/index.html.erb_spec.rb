# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/index', type: :view do
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
    expect_object_list(books)
  end

  it "render a link to new book" do
    expect_link_to_new("book")
  end
end
