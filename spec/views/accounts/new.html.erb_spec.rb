# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/new", type: :view do
  let(:account) { build(:account) }

  before(:each) do
    assign(:account, account)
    assign(:suppliers_without_account, [
             Supplier.create(name: "Supplier 1"),
             Supplier.create(name: "Supplier 2")
           ])
    render
  end

  it "renders the page title" do
    expect_page_title("New account")
  end

  it "renders new account form" do
    expect(rendered).to have_selector("form[action='#{accounts_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='account[account_number]']")
      expect(rendered).to have_selector("select[name='account[supplier_id]']")
      expect(rendered).to have_select("account_supplier_id", with_options: ["Supplier 1", "Supplier 2"])
      expect_submit_button("Create Account")
    end
  end

  it "renders the back link" do
    expect_link_back_to("accounts")
  end
end
