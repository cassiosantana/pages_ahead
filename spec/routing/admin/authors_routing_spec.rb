# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::AuthorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "admin/authors").to route_to("admin/authors#index")
    end

    it "routes to #new" do
      expect(get: "admin/authors/new").to route_to("admin/authors#new")
    end

    it "routes to #show" do
      expect(get: "admin/authors/1").to route_to("admin/authors#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "admin/authors/1/edit").to route_to("admin/authors#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "admin/authors").to route_to("admin/authors#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/authors/1").to route_to("admin/authors#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/authors/1").to route_to("admin/authors#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "admin/authors/1").to route_to("admin/authors#destroy", id: "1")
    end
  end
end
