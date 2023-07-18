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
    it "render the link to edit author" do
      expect_link_to_edit(author)
    end

    it "render the link to edit author" do
      expect_link_back_to("authors")
    end

    it "renders the button to destroy author" do
      expect_submit_button("Destroy this author")
    end
  end
end
