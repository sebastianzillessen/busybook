module Schedules
  class OfferedSchedule < Schedule

    default_scope { where("offer_id is not null AND approved != ?", true) }


    def set_event_offer_attributes
      self.summary = "[TBC] Proposed Meeting with #{self.offer.email}"
      self.url = accept_link
      self.description = "This is a possible slot for this meeting. Please accept one slot with the link below. To reject this slot please visit: #{reject_link}"
    end

    def accept!
      self.offer.offered_schedules.reject { |x| x == self }.each(&:destroy)
      self.summary = self.offer.description
      self.url = ""
      self.description = ""
      othercal = self.user.calendars.where("id is not ?", self.calendar).first
      self.calendar = othercal if othercal
      self.offer.approved = true
      self.approved = true


      self.save
    end

    def reject!
      self.rejected = true
      self.save
    end

    def accept_link
      Rails.application.routes.url_helpers.json_offered_schedule_url(self, approve: true)
    end

    def reject_link
      Rails.application.routes.url_helpers.json_offered_schedule_url(self, reject: true)
    end
  end
end