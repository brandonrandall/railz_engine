class Api::V1::InvoiceItems::FindController < ApplicationController
  def index
    render json: InvoiceItem.where(search_params)
  end
  def show
    render json: InvoiceItem.find_by(search_params)
  end

  private

  def search_params
    params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
