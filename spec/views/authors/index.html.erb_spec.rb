# frozen_string_literal: true

require "rails_helper"

RSpec.describe "authors/index", type: :view do
  let(:authors) { create_list(:author, 3) }

  before(:each) do
    assign(:authors, authors)
    render
  end

  it "renders the page title" do
    expect_page_title("Authors")
  end

  it "renders the link to create a new author" do
    expect_link_to_new("author")
  end

  it "renders the list of authors" do
    authors.each do |author|
      expect(rendered).to have_text("Name: #{author.name}", normalize_ws: true)
      expect(rendered).to have_link("Show this author", href: admin_author_path(author))
    end
  end
end
