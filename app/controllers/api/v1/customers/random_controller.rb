class Api::V1::Customers::RandomController < ApplicationController
  def show
    random_id = Customer.pluck(:id).sample
    render json: Customer.find(random_id)
  end
end
