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
    expect_object_list(accounts)
  end

  it "renders the page title" do
    expect_page_title("Accounts")
  end

  it "renders the link to create a new account" do
    expect_link_to_new("account")
  end
end
