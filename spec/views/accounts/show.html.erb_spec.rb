# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { create(:account, supplier: supplier) }

  before(:each) do
    assign(:account, account)
    render
  end

  it "renders account attributes" do
    expect(rendered).to have_selector("p", text: "Supplier:\n    #{account.supplier.name}")
    expect(rendered).to have_selector("p", text: "Account number:\n    #{account.account_number}")
  end
end
