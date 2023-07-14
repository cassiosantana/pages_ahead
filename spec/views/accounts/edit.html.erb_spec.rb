# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/edit", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { create(:account, supplier: supplier) }

  before(:each) do
    assign(:account, account)
    render
  end

  context "account attribute rendering" do
    it "render account number" do
      expect(rendered).to have_selector("div", text: "Account number:\n        #{account.account_number}")
    end

    it "render supplier name" do
      expect(rendered).to have_selector("div", text: "Supplier:\n        #{account.supplier.name}")
    end
  end

  context "message that it is not possible to edit the attribute" do
    it "render account number message" do
      expect(rendered).to have_selector("em", text: "It is not possible to change the account number.")
    end

    it "render supplier message" do
      expect(rendered).to have_selector("em", text: "It is not possible to change the supplier.")
    end
  end
end
