# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/authors/new", type: :view do
  before(:each) do
    assign(:author, build(:author))
    render
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "New author")
  end

  it "renders new author form" do
    expect(rendered).to have_selector("form[action='#{admin_authors_path}'][method='post']")
    expect(rendered).to have_selector("input[name='author[name]']")
    expect(rendered).to have_selector("input[name='author[cpf]']")
  end

  it "renders the back link" do
    expect(rendered).to have_link("Back to authors", href: admin_authors_path)
  end
end
