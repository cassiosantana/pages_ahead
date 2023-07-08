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
end
