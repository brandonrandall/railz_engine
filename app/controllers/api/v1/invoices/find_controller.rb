class Api::V1::Invoices::FindController < ApplicationController
  def index
    render json: Invoice.where(search_params)
  end
  def show
    render json: Invoice.find_by(search_params)
  end

  private

  def search_params
    params.permit(:id,
                  :status,
                  :created_at, :updated_at, :customer_id, :merchant_id)
  end
end
