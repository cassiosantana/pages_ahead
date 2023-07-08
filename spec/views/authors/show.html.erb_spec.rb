# frozen_string_literal: true

require "rails_helper"

RSpec.describe "authors/show", type: :view do
  let(:author) { create(:author) }
  let(:books) { create_list(:book, 3, author: author) }

  before(:each) do
    assign(:author, author)
    render
  end

  context "rendering of author attributes" do
    it "renders the author name" do
      expect(rendered).to have_text("Name: #{author.name}")
    end

    it "renders the author's books" do
      expect(rendered).to have_selector("p strong", text: "Books:")
      author.books.each do |book|
        expect(rendered).to have_selector("ul li", text: book.published_at)
      end
    end
  end

  context "rendering links and button" do
    it "renders the link to edit author" do
      expect(rendered).to have_link("Edit this author", href: edit_author_path(author))
    end

    it "renders the link to edit author" do
      expect(rendered).to have_link("Back to authors", href: authors_path)
    end

    it "renders the button to destroy author" do
      expect(rendered).to have_button("Destroy this author")
    end
  end
end
