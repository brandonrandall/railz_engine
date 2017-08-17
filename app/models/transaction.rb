class Transaction < ApplicationRecord
  belongs_to :invoice
  # belongs_to :customer
  # belongs_to :merchant
end
