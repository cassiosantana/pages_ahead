# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
             Account.create!(
               supplier: nil,
               account_number: "Account Number"
             ),
             Account.create!(
               supplier: nil,
               account_number: "Account Number"
             )
           ])
  end

  it "renders a list of accounts" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Account Number".to_s), count: 2
  end
end
