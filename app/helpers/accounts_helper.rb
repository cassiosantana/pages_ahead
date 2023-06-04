# frozen_string_literal: true

module AccountsHelper
  def suppliers_without_account
    Supplier.where.not(id: Account.select('supplier_id'))
  end
end
