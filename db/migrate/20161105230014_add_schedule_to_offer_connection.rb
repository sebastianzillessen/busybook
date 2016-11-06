class AddScheduleToOfferConnection < ActiveRecord::Migration[5.0]
  def change
    add_reference :schedules, :offer, index: true
  end
end
