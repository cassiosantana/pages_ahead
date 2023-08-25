# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/edit", type: :view do
  let(:books) { create_list(:book, rand(0..10)) }
  let(:parts) { create_list(:part, rand(0..10)) }
  let(:assembly) { create(:assembly, books: books, parts: parts) }

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  it " render the page title" do
    expect_page_title("Editing assembly")
  end

  it "render the edit assembly form" do
    form = "form[action='#{assembly_path(assembly)}'][method='post']"
    name = "input[name='assembly[name]'][value='#{assembly.name}']"
    assembly_parts = "input[type='checkbox'][name='assembly[part_ids][]']"
    assembly_books = "input[type='checkbox'][name='assembly[book_ids][]']"

    expect(rendered).to have_selector(form)
    expect(rendered).to have_selector(name)
    expect(rendered).to have_selector(assembly_parts, count: Part.count)
    expect(rendered).to have_selector(assembly_books, count: Book.count)
    assembly.parts.each do |part|
      expect(rendered).to have_text(part.name)
    end
    assembly.books.each do |book|
      expect(rendered).to have_text(book.title)
    end
    expect_submit_button("Update Assembly")
  end

  it "render the show link" do
    expect_link_to_show(assembly)
  end

  it "render the back link" do
    expect_link_back_to("assemblies")
  end
end
