class Customer < ApplicationRecord
  # validates_presence_of :id,:first_name,:last_name
  validates :first_name, :last_name, presence: true
end
