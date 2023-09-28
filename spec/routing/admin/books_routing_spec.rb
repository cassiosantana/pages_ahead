# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::BooksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "admin/books").to route_to("admin/books#index")
    end

    it "routes to #new" do
      expect(get: "admin/books/new").to route_to("admin/books#new")
    end

    it "routes to #show" do
      expect(get: "admin/books/1").to route_to("admin/books#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "admin/books/1/edit").to route_to("admin/books#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "admin/books").to route_to("admin/books#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/books/1").to route_to("admin/books#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/books/1").to route_to("admin/books#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "admin/books/1").to route_to("admin/books#destroy", id: "1")
    end
  end
end
