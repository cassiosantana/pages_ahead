# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/index", type: :view do
  include ViewTestHelper

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
end
