# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'suppliers/new', type: :view do
  before(:each) do
    assign(:supplier, Supplier.new(
                        name: 'MyString'
                      ))
  end

  it 'renders new supplier form' do
    render

    assert_select 'form[action=?][method=?]', suppliers_path, 'post' do
      assert_select 'input[name=?]', 'supplier[name]'
    end
  end
end
