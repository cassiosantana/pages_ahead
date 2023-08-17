# frozen_string_literal: true

require "rails_helper"

RSpec.describe "books/new", type: :view do
  let(:book) { build(:book) }

  before(:each) do
    assign(:book, book)
    assign(:authors, [
             Author.create(name: "Author 1"),
             Author.create(name: "Author 2")
           ])
    assign(:assemblies, create_list(:assembly, rand(11)))

    render
  end

  it "render the page title" do
    expect_page_title("New book")
  end

  it "render the book form" do
    expect(rendered).to have_selector("form[action='#{books_path}'][method='post']")
    expect(rendered).to have_selector("input[type='datetime-local'][name='book[published_at]']")
    expect(rendered).to have_selector("input[type='text'][name='book[isbn]']")
    expect(rendered).to have_selector("select[name='book[author_id]']")
    expect(rendered).to have_select("book_author_id", with_options: ["Author 1", "Author 2"])
    expect(rendered).to have_selector("input[type='checkbox'][name='book[assembly_ids][]']", count: Assembly.count)
    expect_submit_button("Create Book")
  end

  it "render the back link" do
    expect_link_back_to("books")
  end
end
