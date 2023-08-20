# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true
  validates :cpf, presence: true
  validate :cpf_valid?

  private

  def cpf_valid?
    errors.add(:cpf, "is invalid") unless CPF.valid?(cpf)
  end
end
