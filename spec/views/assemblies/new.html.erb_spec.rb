# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/new", type: :view do
  let(:assembly) do
    build(:assembly,
          books: create_list(:book, 5, author: create(:author)),
          parts: create_list(:part, 3, supplier: create(:supplier)))
  end

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  it "render the page title" do
    expect_page_title("New assembly")
  end

  it "render the edit assembly form" do
    expect(rendered).to have_selector("form[action='#{assemblies_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='assembly[name]']")
      expect(rendered).to have_selector("input[type='checkbox'][name='assembly[part_ids][]']", count: 3)
      expect(rendered).to have_selector("input[type='checkbox'][name='assembly[book_ids][]']", count: 5)
      expect_submit_button("Create Assembly")
    end
  end
end
