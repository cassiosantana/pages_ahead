# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/show', type: :view do
  before(:each) do
    assign(:book, Book.create!(
                    author: nil
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
  end
end
