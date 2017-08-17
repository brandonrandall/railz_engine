class AddCustomerToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :customer, foreign_key: true
  end
end
