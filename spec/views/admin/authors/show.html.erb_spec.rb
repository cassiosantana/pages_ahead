# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/authors/show", type: :view do
  let(:author) { create(:author) }
  let(:books) { create_list(:book, 3, author:) }

  before(:each) do
    assign(:author, author)
    render
  end

  context "when trying to display the attributes and associations" do
    it "they are displayed correctly" do
      expect(rendered).to have_text("Name: #{author.name}", normalize_ws: true)
      expect(rendered).to have_text("Cpf: #{author.cpf}", normalize_ws: true)
    end
  end

  context "rendering links and button" do
    it "render the link to edit author" do
      expect(rendered).to have_link("Edit this author", href: edit_admin_author_path(author))
    end

    it "render the link to edit author" do
      expect(rendered).to have_link("Back to authors", href: admin_authors_path)
    end

    it "renders the button to destroy author" do
      expect(rendered).to have_button("Destroy this author")
    end
  end
end
