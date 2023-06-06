# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "validations" do
    let(:author) { build(:author) }

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
end
