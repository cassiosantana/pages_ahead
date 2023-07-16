# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/index", type: :view do
  let(:assemblies) { create_list(:assembly, 5) }

  before(:each) do
    assign(:assemblies, assemblies)
    render
  end

  it "render the page title" do
    expect_page_title("Assemblies")
  end

  it "render a list of assemblies" do
    expect_entity_list(assemblies)
  end

  it "render a link to new assembly" do
    expect_link_to_new("assembly")
  end
end
