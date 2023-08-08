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
end
