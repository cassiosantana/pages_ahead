# frozen_string_literal: true

class CreateParts < ActiveRecord::Migration[7.0]
  def change
    create_table :parts do |t|
      t.string :part_number
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
