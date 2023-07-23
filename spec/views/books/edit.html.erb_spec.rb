# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/edit', type: :view do
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

  it "render the book form" do
    expect(rendered).to have_selector("form[action='#{book_path(book)}'][method='post']") do
      expect(rendered).to have_selector("input[type='datetime-local'][name='book[published_at]']")
      expect(DateTime.parse(Capybara.string(rendered)
                                    .find("input[name='book[published_at]']")
                                    .value).utc.iso8601).to eq(book.published_at.utc.iso8601)
      expect(rendered).to have_selector("select[name='book[author_id]']")
      expect(rendered).to have_select("book[author_id]", selected: book.author.name)
      expect(rendered).to have_select("book_author_id", with_options: authors.pluck(:name))
      expect(rendered).to have_selector("input[type='checkbox'][name='book[assembly_ids][]']", count: Assembly.count)
      Assembly.all.each do |assembly|
        if book.assemblies.include?(assembly)
          expect(rendered).to have_selector("input[type='checkbox'][name='book[assembly_ids][]'][value='#{assembly.id}'][checked]")
        else
          expect(rendered).to have_selector("input[type='checkbox'][name='book[assembly_ids][]'][value='#{assembly.id}']:not([checked])")
        end
      end
      expect_submit_button("Update Book")
    end
  end

  it "render the show book link" do
    expect_link_to_show(book)
  end

  it "render the back link" do
    expect_link_back_to("books")
  end
end
