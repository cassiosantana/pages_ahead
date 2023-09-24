# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/authors/edit", type: :view do
  let(:author) { create(:author) }

  before(:each) do
    assign(:author, author)
    render
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "Editing author")
  end

  context "editing the author" do
    it "renders the edit author form" do
      expect(rendered).to have_selector("form[action='#{admin_author_path(author)}'][method='post']")
      expect(rendered).to have_selector("input[name='author[name]'][value='#{author.name}']")
      expect(rendered).to have_selector("input[name='author[cpf]'][value='#{author.cpf}']")
      expect(rendered).to have_button("Update Author")
    end
  end

  context "rendering links" do
    it "renders the back link" do
      expect(rendered).to have_link("Back to authors", href: admin_authors_path)
    end

    it "renders the show link" do
      expect(rendered).to have_link("Show this author", href: admin_author_path(author))
    end
  end
end
