# frozen_string_literal: true

class AddTitleToBook < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :title, :string
  end
end
