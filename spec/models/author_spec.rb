# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { create(:author) }

  describe "validations" do

    context "when name is present" do

      it "author is created" do
        expect(author).to be_valid
      end
    end

    context "when name is not present" do
      let(:author) { build(:author, name: nil) }

      it "author is not created" do
        expect(author).to be_invalid
        expect(author.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe "editing" do
    context "when updating the name" do
      it "updates the name correctly" do

        expect do
          author.name = "another full name"
          author.save
          author.reload
        end.to change { author.name }.to("another full name")
      end

      it "does not allow an empty name" do

        author.name = nil
        author.save
        expect(author.errors[:name]).to include("can't be blank")
      end
    end
  end
end
