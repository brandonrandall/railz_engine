class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.most_revenue(params[:id])
  end
end
