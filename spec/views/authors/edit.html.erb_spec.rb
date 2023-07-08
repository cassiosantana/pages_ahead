# frozen_string_literal: true

require "rails_helper"

RSpec.describe "authors/edit", type: :view do
  let(:author) { create(:author) }

  before(:each) do
    assign(:author, author)
    render
  end

  it "renders the edit author form" do
    expect(rendered).to have_selector("form[action='#{author_path(author)}'][method='post']") do
      expect(rendered).to have_selector("input[name='author[name]']")
    end
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "Editing author")
  end

  it "renders the back link" do
    expect(rendered).to have_link("Back to authors", href: authors_path)
  end

  it "renders the show link" do
    expect(rendered).to have_link("Show this author", href: author_path(author))
  end
end
