# frozen_string_literal: true

class AddPriceToPart < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :price, :decimal
  end
end
