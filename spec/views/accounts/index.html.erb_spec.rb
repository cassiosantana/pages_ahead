# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/index", type: :view do
  let(:suppliers) { create_list(:supplier, 3) }
  let(:accounts) do
    suppliers.map do |supplier|
      create(:account, supplier: supplier)
    end
  end

  before(:each) do
    assign(:accounts, accounts)
    render
  end

  it "renders a list of accounts" do
    expect(rendered).to have_selector("#accounts") do
      accounts.each do |account|
        expect(rendered).to have_selector("p", text: "Account number: #{account.account_number} | Show this account")
      end
    end
  end

  it "renders the page title" do
    expect(rendered).to have_selector("h1", text: "Accounts")
  end
end
