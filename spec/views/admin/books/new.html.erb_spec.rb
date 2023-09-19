# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/books/new", type: :view do
  let(:book) { build(:book) }
  let(:author1) { create(:author, name: "Author 1") }
  let(:author2) { create(:author, name: "Author 2") }

  before(:each) do
    assign(:book, book)
    assign(:authors, [author1, author2])
    assign(:assemblies, create_list(:assembly, rand(11)))

    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "New book")
  end

  it "render the book form" do
    expect(rendered).to have_selector("form[action='#{admin_books_path}'][method='post']")
    expect(rendered).to have_selector("input[type='text'][name='book[title]']")
    expect(rendered).to have_selector("input[type='datetime-local'][name='book[published_at]']")
    expect(rendered).to have_selector("input[type='text'][name='book[isbn]']")
    expect(rendered).to have_selector("select[name='book[author_id]']")
    expect(rendered).to have_select("book_author_id", with_options: ["Author 1", "Author 2"])
    expect(rendered).to have_selector("input[type='checkbox'][name='book[assembly_ids][]']", count: Assembly.count)
    expect_submit_button("Create Book")
  end

  it "render the back link" do
    expect(rendered).to have_link("Back to books", href: admin_books_path)
  end
end
