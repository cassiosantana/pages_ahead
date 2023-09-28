# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/assemblies/edit", type: :view do
  let(:books) { create_list(:book, rand(0..10)) }
  let(:parts) { create_list(:part, rand(0..10)) }
  let(:assembly) { create(:assembly, books:, parts:) }

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  it " render the page title" do
    expect(rendered).to have_selector("h1", text: "Editing assembly")
  end

  it "render the edit assembly form" do
    form = "form[action='#{admin_assembly_path(assembly)}'][method='post']"
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
    expect(rendered).to have_button("Update Assembly")
  end

  it "render the show link" do
    expect(rendered).to have_link("Show this assembly", href: admin_assembly_path(assembly))
  end

  it "render the back link" do
    expect(rendered).to have_link("Back to assemblies", href: admin_assemblies_path)
  end
end
