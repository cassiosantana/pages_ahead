# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Assemblies", type: :request do
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, rand(1..10), supplier: supplier) }
  let(:books) { create_list(:book, rand(1..10)) }

  shared_examples "verify assembly creation" do
    it "the assembly is successfully created" do
      expect(response).to have_http_status :created
      expect(json_response["id"]).to be_present
      expect(json_response["name"]).to eq(valid_data[:assembly][:name])
    end
  end

  shared_examples "verify properties in books and parts" do
    it "returns associations correctly" do
      expect(json_response["books"].length).to eq(books.length)
      json_response["books"].each do |book|
        expect(book["id"]).to be_present
        expect(book["title"]).to be_present
      end
      expect(json_response["parts"].length).to eq(parts.length)
      json_response["parts"].each do |part|
        expect(part["id"]).to be_present
        expect(part["name"]).to be_present
      end
    end
  end

  describe "GET /api/assemblies" do
    context "when request all assemblies" do
      let!(:assemblies) { create_list(:assembly, rand(5..10)) }
      it "list all assemblies" do
        get api_assemblies_path

        expect(response).to have_http_status :ok
        expect(json_response.length).to eq(assemblies.count)

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

  describe "POST /api/assemblies" do
    context "when trying to create an assembly without associations" do
      let!(:valid_data) { { assembly: { name: FFaker::Lorem.word } } }

      before { post api_assemblies_path, params: valid_data }

      include_examples "verify assembly creation"
    end

    context "when trying to create an assembly with associations" do
      let(:valid_data) do
        {
          assembly: {
            name: FFaker::Lorem.word,
            book_ids: books.pluck(:id),
            part_ids: parts.pluck(:id)
          }
        }
      end

      before { post api_assemblies_path, params: valid_data }

      include_examples "verify assembly creation"

      include_examples "verify properties in books and parts"
    end

    context "when trying to create an assembly with invalid data" do
      let!(:invalid_data) { { assembly: { name: "" } } }

      it "the assembly is successfully created" do
        post api_assemblies_path, params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe "PATCH /api/assemblies/:id" do
    context "when trying to update assembly with valid data" do
      let(:valid_data) do
        {
          assembly: {
            name: FFaker::Lorem.word,
            book_ids: books.pluck(:id),
            part_ids: parts.pluck(:id)
          }
        }
      end

      let(:assembly) { create(:assembly) }
      before do
        patch api_assembly_path(assembly), params: valid_data
      end

      it "receive correct status" do
        expect(response).to have_http_status :ok
        expect(json_response["id"]).to be_present
        expect(json_response["name"]).to eq(valid_data[:assembly][:name])
      end

      include_examples "verify properties in books and parts"
    end

    context "when trying to update an assembly with invalid data" do
      let(:assembly) { create(:assembly) }
      let(:invalid_data) { { assembly: { name: "" } } }

      it "the assembly is successfully created" do
        patch api_assembly_path(assembly), params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe "DELETE /api/assemblies/:id" do
    context "when trying to delete an existing assembly" do
      let!(:assembly) { create(:assembly) }

      it "the assembly is deleted successfully" do
        delete api_assembly_path(assembly)

        expect(response).to have_http_status :no_content
      end
    end

    context "when trying to delete an assembly" do
      it "when trying to delete a non-existent assembly" do
        delete api_assembly_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Assembly not found.")
      end
    end

    context "when deleting assembly fails" do
      let!(:assembly) { create(:assembly) }

      it "we received the status and error message correctly" do
        allow_any_instance_of(Assembly).to receive(:destroy).and_return(false)

        delete api_assembly_path(assembly)

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["message"]).to eq("Failed to delete the assembly.")
      end
    end
  end
end
