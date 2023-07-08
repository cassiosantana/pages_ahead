# frozen_string_literal: true

require "rails_helper"

RSpec.describe "authors/index", type: :view do
  let(:authors) { create_list(:author, 3) }

  before(:each) do
    assign(:authors, authors)
    render
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "Authors")
  end

  it "renders the link to create a new author" do
    expect(rendered).to have_link("New author", href: new_author_path)
  end

  it "renders the list of authors" do
    expect(rendered).to have_selector("#authors") do
      authors.each do |author|
        expect(rendered).to have_selector("p", text: "Author: #{author.name} | Show this author")
      end
    end
  end
end
