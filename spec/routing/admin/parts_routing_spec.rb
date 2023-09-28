# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::PartsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "admin/parts").to route_to("admin/parts#index")
    end

    it "routes to #new" do
      expect(get: "admin/parts/new").to route_to("admin/parts#new")
    end

    it "routes to #show" do
      expect(get: "admin/parts/1").to route_to("admin/parts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "admin/parts/1/edit").to route_to("admin/parts#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "admin/parts").to route_to("admin/parts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/parts/1").to route_to("admin/parts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/parts/1").to route_to("admin/parts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "admin/parts/1").to route_to("admin/parts#destroy", id: "1")
    end
  end
end
