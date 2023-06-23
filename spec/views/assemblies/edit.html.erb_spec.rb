# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/edit", type: :view do
  let(:assembly) do
    Assembly.create!(
      name: "MyString"
    )
  end

  before(:each) do
    assign(:assembly, assembly)
  end

  it "renders the edit assembly form" do
    render

    assert_select "form[action=?][method=?]", assembly_path(assembly), "post" do
      assert_select "input[name=?]", "assembly[name]"
    end
  end
end
