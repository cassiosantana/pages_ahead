# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/edit", type: :view do
  let(:author) { create(:author) }
  let(:books) { create_list(:book, 5, author: author) }
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier: supplier) }
  let(:assembly) { create(:assembly, books: books, parts: parts) }

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  it "renders the edit assembly form" do
    expect(rendered).to have_selector("form[action='#{assembly_path(assembly)}'][method='post']") do
      expect(rendered).to have_selector("input[name='assembly[name]']")
      expect(rendered).to have_selector("input[type='checkbox'][name='assembly[part_ids][]']", count: 3)
      expect(rendered).to have_selector("input[type='checkbox'][name='assembly[book_ids][]']", count: 5)
    end
  end
end
