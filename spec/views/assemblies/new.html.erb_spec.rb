# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/new", type: :view do
  let(:books) { create_list(:book, 5) }
  let(:parts) { create_list(:part, 3) }

  before(:each) do
    assign(:assembly, build(:assembly))
    assign(:books, books)
    assign(:parts, parts)
    render
  end

  it "render the page title" do
    expect_page_title("New assembly")
  end

  it "render the edit assembly form" do
    form = "form[action='#{assemblies_path}'][method='post']"
    name = "input[name='assembly[name]']"
    assembly_parts = "input[type='checkbox'][name='assembly[part_ids][]']"
    assembly_books = "input[type='checkbox'][name='assembly[book_ids][]']"

    expect(rendered).to have_selector(form)
    expect(rendered).to have_selector(name)
    expect(rendered).to have_selector(assembly_parts, count: 3)
    Part.all.each do |part|
      expect(rendered).to have_text(part.part_number)
    end
    expect(rendered).to have_selector(assembly_books, count: 5)
    Book.all.each do |book|
      expect(rendered).to have_text(book.title)
    end
    expect_submit_button("Create Assembly")
  end

  it "render the back link" do
    expect_link_back_to("assemblies")
  end
end
