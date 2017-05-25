class EventLodgingDecorator < ApplicationDecorator
  decorates_association :lodging

  delegate :description, :lodging_type, :max_capacity, :min_capacity, :name, to: :lodging

  def object_id
    object.id
  end
end
