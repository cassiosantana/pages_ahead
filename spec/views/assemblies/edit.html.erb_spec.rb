# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/edit", type: :view do
  let(:author) { create(:author) }
  let(:supplier) { create(:supplier) }
  let(:books) { create_list(:book, FFaker::Random.rand(0..10), author: author) }
  let(:parts) { create_list(:part, FFaker::Random.rand(0..10), supplier: supplier) }
  let(:assembly) { create(:assembly, books: books, parts: parts) }

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  it " render the page title" do
    expect_page_title("Editing assembly")
  end

  it "render the edit assembly form" do
    expect(rendered).to have_selector("form[action='#{assembly_path(assembly)}'][method='post']") do
      expect(rendered).to have_selector("input[name='assembly[name]'][value='#{assembly.name}']")
      expect(rendered).to have_selector("input[type='checkbox'][name='assembly[part_ids][]']", count: Part.count)
      expect(rendered).to have_selector("input[type='checkbox'][name='assembly[book_ids][]']", count: Book.count)
      expect_submit_button("Update Assembly")
    end
  end

  it "render the show link" do
    expect_link_to_show(assembly)
  end

  it "render the back link" do
    expect_link_back_to("assemblies")
  end
end
