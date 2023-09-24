# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::AssembliesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "admin/assemblies").to route_to("admin/assemblies#index")
    end

    it "routes to #new" do
      expect(get: "admin/assemblies/new").to route_to("admin/assemblies#new")
    end

    it "routes to #show" do
      expect(get: "admin/assemblies/1").to route_to("admin/assemblies#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "admin/assemblies/1/edit").to route_to("admin/assemblies#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "admin/assemblies").to route_to("admin/assemblies#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/assemblies/1").to route_to("admin/assemblies#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/assemblies/1").to route_to("admin/assemblies#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "admin/assemblies/1").to route_to("admin/assemblies#destroy", id: "1")
    end
  end
end
