# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/new', type: :view do
  let(:book) { build(:book) }

  before(:each) do
    assign(:book, book)
    assign(:authors, [
             Author.create(name: "Author 1"),
             Author.create(name: "Author 2")
           ])
    assign(:assemblies, create_list(:assembly, rand(11)))

    render
  end

  it "render the page title" do
    expect_page_title("New book")
  end
end
