class Offer < ApplicationRecord
  belongs_to :user
  has_many :offered_schedules, class_name: Schedules::OfferedSchedule
  accepts_nested_attributes_for :offered_schedules, reject_if: :all_blank, allow_destroy: true

  after_save :set_event_offer_attributes


  private
  def set_event_offer_attributes
    offered_schedules.each(&:set_event_offer_attributes)
    offered_schedules.each(&:save)
  end

end
