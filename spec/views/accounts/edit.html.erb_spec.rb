# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/edit", type: :view do
  let(:account) do
    Account.create!(
      supplier: nil,
      account_number: "MyString"
    )
  end

  before(:each) do
    assign(:account, account)
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(account), "post" do
      assert_select "input[name=?]", "account[supplier_id]"

      assert_select "input[name=?]", "account[account_number]"
    end
  end
end
