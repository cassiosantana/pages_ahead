# frozen_string_literal: true

require "rails_helper"

RSpec.describe "home/index.html.erb", type: :view do
  describe "index" do
    it "renders the correct HTML elements" do
      render

      expect(rendered).to have_selector("h1", text: "Welcome to Book Publisher")
      expect(rendered).to have_selector("p", text: "Book Publisher is an application that allows you to perform CRUD operations. With this application, you can register Authors, create Accounts, add Assemblies, Parts, Books, and Suppliers. Additionally, you can associate Accounts with Authors, Assemblies with Parts and Books, and Suppliers with Parts.")
    end
  end
end
