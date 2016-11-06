class CalendarSerializer < ActiveModel::Serializer
  attributes :id, :color
  has_many :schedules, key: :events

end
