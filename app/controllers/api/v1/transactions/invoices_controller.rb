class Api::V1::Transactions::InvoicesController < ApplicationController
  def index
    render json: Transaction.find(params[:id]).invoice
    # binding.pry
  end
end
