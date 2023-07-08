# frozen_string_literal: true

require "rails_helper"

RSpec.describe "authors/new", type: :view do
  before(:each) do
    assign(:author, build(:author))
    render
  end

  it "renders new author form" do

    expect(rendered).to have_selector("form[action='#{authors_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='author[name]']")
    end
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "New author")
  end
end
