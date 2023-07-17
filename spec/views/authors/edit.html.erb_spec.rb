# frozen_string_literal: true

require "rails_helper"

RSpec.describe "authors/edit", type: :view do
  let(:author) { create(:author) }

  before(:each) do
    assign(:author, author)
    render
  end

  it "renders the page title" do
    expect_page_title("Editing author")
  end

  context "editing the author" do
    it "renders the edit author form" do
      expect(rendered).to have_selector("form[action='#{author_path(author)}'][method='post']") do
        expect(rendered).to have_selector("input[name='author[name]']")
        expect_submit_button("Update Author")
      end
    end
  end

  context "rendering links" do
    it "renders the back link" do
      expect_link_back_to("authors")
    end

    it "renders the show link" do
      expect_link_to_show(author)
    end
  end
end
