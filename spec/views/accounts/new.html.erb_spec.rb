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
end
