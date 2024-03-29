# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/accounts/index", type: :view do
  let(:suppliers) { create_list(:supplier, 3) }
  let(:accounts) do
    suppliers.map do |supplier|
      create(:account, supplier:)
    end
  end

  before(:each) do
    assign(:accounts, accounts)
    render
  end

  it "renders a list of accounts" do
    accounts.each do |account|
      expect(rendered).to have_text("Number: #{account.number_with_digit}", normalize_ws: true)
      expect(rendered).to have_link("Show this account", href: admin_account_path(account))
    end
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "Accounts")
  end

  it "renders the link to create a new account" do
    expect(rendered).to have_link("New account", href: new_admin_account_path)
  end
end
