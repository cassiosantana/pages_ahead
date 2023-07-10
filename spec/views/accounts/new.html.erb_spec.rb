# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/new", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { build(:account, supplier: supplier) }

  before(:each) do
    assign(:account, account)
    render
  end

  it "renders new account form" do
    expect(rendered).to have_selector("form[action='#{accounts_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='account[account_number]']")
    end
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "New account")
  end

  it "renders the back link" do
    expect(rendered).to have_link("Back to accounts", href: accounts_path)
  end

  it "renders the create account button" do
    expect(rendered).to have_button("Create Account")
  end

  it "displays the supplier dropdown" do
    assign(:account, Account.new)
    assign(:suppliers_without_account, [
             Supplier.create(name: "Supplier 1"),
             Supplier.create(name: "Supplier 2")
           ])

    render

    expect(rendered).to have_select("account_supplier_id", with_options: ["Supplier 1", "Supplier 2"])
  end
end
