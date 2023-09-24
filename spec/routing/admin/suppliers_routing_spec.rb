# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::SuppliersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "admin/suppliers").to route_to("admin/suppliers#index")
    end

    it "routes to #new" do
      expect(get: "admin/suppliers/new").to route_to("admin/suppliers#new")
    end

    it "routes to #show" do
      expect(get: "admin/suppliers/1").to route_to("admin/suppliers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "admin/suppliers/1/edit").to route_to("admin/suppliers#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "admin/suppliers").to route_to("admin/suppliers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/suppliers/1").to route_to("admin/suppliers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/suppliers/1").to route_to("admin/suppliers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "admin/suppliers/1").to route_to("admin/suppliers#destroy", id: "1")
    end
  end
end
