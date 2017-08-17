class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])

    if params[:date]
      render json: { "revenue" => merchant.total_revenue_by_date(params[:date]) }
    else
      render json: { "revenue" => merchant.total_revenue }
    end
  end
end
