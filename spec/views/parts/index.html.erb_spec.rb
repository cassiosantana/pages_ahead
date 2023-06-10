# frozen_string_literal: true

require "rails_helper"

RSpec.describe "parts/index", type: :view do
  before(:each) do
    assign(:parts, [
             Part.create!(
               part_number: "Part Number",
               supplier: nil
             ),
             Part.create!(
               part_number: "Part Number",
               supplier: nil
             )
           ])
  end

  it "renders a list of parts" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("Part Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
