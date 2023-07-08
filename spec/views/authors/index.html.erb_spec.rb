# frozen_string_literal: true

require "rails_helper"

RSpec.describe "authors/index", type: :view do
  let(:authors) { create_list(:author, 3) }

  before(:each) do
    assign(:authors, authors)
    render
  end

  it "renders the page title" do
    assert_select "h1", text: "Authors"
  end

  it "renders the link to create a new author" do
    assert_select "a[href=?]", new_author_path, text: "New author"
  end

  it "renders the list of authors" do
    assert_select "#authors" do
      authors.each do |author|
        assert_select "p", text: "Author: #{author.name} | Show this author"
      end
    end
  end
end
