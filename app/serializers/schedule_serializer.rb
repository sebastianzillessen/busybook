class ScheduleSerializer < ActiveModel::Serializer
  attributes :id
  attribute :summary, key: :title
  attribute :date_start, key: :start
  attribute :date_end, key: :end
  attribute(:edit_url) {
    view_context.json_schedule_path(object)
  }

end
