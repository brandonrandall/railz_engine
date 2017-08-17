class Api::V1::Customers::InvoicesController < ApplicationController
  def index
    # binding.pry
    render json: Customer.find(params[:id]).invoices
  end
end
