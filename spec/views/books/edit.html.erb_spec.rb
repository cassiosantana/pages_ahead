# frozen_string_literal: true

require "rails_helper"

RSpec.describe "books/edit", type: :view do
  let(:authors) { create_list(:author, 3) }
  let(:not_associated_assemblies) { create_list(:assembly, 3) }
  let(:associated_assemblies) { create_list(:assembly, 4) }
  let(:book) { create(:book, author: authors.first, assemblies: associated_assemblies) }

  before(:each) do
    assign(:book, book)
    assign(:not_associated_assemblies, not_associated_assemblies)
    assign(:authors, authors)
    render
  end

  it "render the page title" do
    expect_page_title("Editing book")
  end

  it "renders the book form" do
    form = "form[action='#{book_path(book)}'][method='post']"
    title = "input[type='text'][name='book[title]'][value='#{book.title}']"
    datetime = "input[type='datetime-local'][name='book[published_at]']"
    isbn = "input[type='text'][name='book[isbn]'][value='#{book.isbn}']"
    author = "select[name='book[author_id]']"
    assembly = "input[type='checkbox'][name='book[assembly_ids][]']"

    expect(rendered).to have_selector(form)
    expect(rendered).to have_selector(title)
    expect(rendered).to have_selector(datetime)
    expect(rendered).to have_selector(isbn)
    expect(rendered).to have_selector(author)
    expect(rendered).to have_select("book[author_id]", selected: book.author.name)
    expect(rendered).to have_select("book_author_id", with_options: authors.pluck(:name))
    expect(rendered).to have_selector(assembly, count: Assembly.count)

    Assembly.all.each do |object|
      assembly_id = "input[type='checkbox'][name='book[assembly_ids][]'][value='#{object.id}']"
      expect(rendered).to have_selector(book.assemblies.include?(object) ? "#{assembly_id}[checked]" : "#{assembly_id}:not([checked])")
    end

    datetime_input_value = Capybara.string(rendered).find(datetime).value
    expect(DateTime.parse(datetime_input_value).utc.iso8601).to eq(book.published_at.utc.iso8601)

    expect_submit_button("Update Book")
  end

  it "render the show book link" do
    expect_link_to_show(book)
  end

  it "render the back link" do
    expect_link_back_to("books")
  end
end
