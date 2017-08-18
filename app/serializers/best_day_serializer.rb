class BestDaySerializer < ActiveModel::Serializer
  attributes :id, :best_day

  def best_day
    object.created_at
  end
end
