class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name

  def most_revenue
    object
  end

  def favorite_customer
    object
  end

end
