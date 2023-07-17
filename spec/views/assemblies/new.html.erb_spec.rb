# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/new", type: :view do
  let(:assembly) { create(:assembly) }

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  it "render the page title" do
    expect_page_title("New assembly")
  end
end
