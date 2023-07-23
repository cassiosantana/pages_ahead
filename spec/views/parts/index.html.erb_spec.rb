# frozen_string_literal: true

require "rails_helper"

RSpec.describe "parts/index", type: :view do
  let!(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier: supplier) }

  before(:each) do
    assign(:parts, parts)
    render
  end

  it "render the page title" do
    expect_page_title("Parts")
  end

  it "render a list of parts" do
    expect_object_list(parts)
  end

  it "render a link to new assembly" do
    expect_link_to_new("part")
  end
end
