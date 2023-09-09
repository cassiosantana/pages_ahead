# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :parts, dependent: :destroy

  validates :name, presence: true
  validates :cnpj, presence: true
  validate :cnpj_valid?

  def account_with_digit
    return unless account

    [account.account_number, account.check_digit].compact.join(" - ")
  end

  def self.find_with_associations(id)
    includes(parts: { assemblies: { books: :author } }).find(id)
  end

  def associated_authors
    parts.map { |part| part.assemblies.map { |assembly| assembly.books.map(&:author) } }.flatten.uniq
  end

  def associated_books
    parts.map { |part| part.assemblies.map(&:books) }.flatten.uniq
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[account parts]
  end

  private

  def cnpj_valid?
    errors.add(:cnpj, "is invalid") unless CNPJ.valid?(cnpj)
  end
end
