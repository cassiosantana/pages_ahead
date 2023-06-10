# frozen_string_literal: true

require "rails_helper"

RSpec.describe "parts/edit", type: :view do
  let(:part) do
    Part.create!(
      part_number: "MyString",
      supplier: nil
    )
  end

  before(:each) do
    assign(:part, part)
  end

  it "renders the edit part form" do
    render

    assert_select "form[action=?][method=?]", part_path(part), "post" do
      assert_select "input[name=?]", "part[part_number]"

      assert_select "input[name=?]", "part[supplier_id]"
    end
  end
end
