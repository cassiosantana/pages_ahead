# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Assemblies", type: :request do
  describe "GET /api/assemblies" do
    context "when request all assemblies" do
      let!(:assemblies) { create_list(:assembly, rand(1..10)) }

      it "list all assemblies" do
        get api_assemblies_path

        expect(response).to have_http_status :ok
        expect(json_response.length).to eq(assemblies.length)

        assembly_ids = assemblies.map(&:id)
        assembly_names = assemblies.map(&:name)
        json_response.each do |assembly|
          expect(assembly_ids).to include(assembly["id"])
          expect(assembly_names).to include(assembly["name"])
        end
      end
    end
  end

  describe "GET /api/assemblies/:id" do
    context "when assembly exist" do
      let!(:assembly) { create(:assembly) }

      it "show assembly data correctly" do
        get api_assembly_path(assembly)

        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(assembly.id)
        expect(json_response["name"]).to eq(assembly.name)
      end
    end

    context "when assembly does not exist" do
      it "show assembly data correctly" do
        get api_assembly_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Assembly not found.")
      end
    end
  end
end
