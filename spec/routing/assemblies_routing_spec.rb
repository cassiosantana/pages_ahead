# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssembliesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/assemblies").to route_to("assemblies#index")
    end

    it "routes to #new" do
      expect(get: "/assemblies/new").to route_to("assemblies#new")
    end

    it "routes to #show" do
      expect(get: "/assemblies/1").to route_to("assemblies#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/assemblies/1/edit").to route_to("assemblies#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/assemblies").to route_to("assemblies#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/assemblies/1").to route_to("assemblies#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/assemblies/1").to route_to("assemblies#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/assemblies/1").to route_to("assemblies#destroy", id: "1")
    end
  end
end
