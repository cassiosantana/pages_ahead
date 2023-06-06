# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "validations" do
    let(:author) { create(:author) }

    context "when name is present" do

      it "author is created" do
        expect(author).to be_valid
      end
    end
  end
end
