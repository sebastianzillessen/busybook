class AddApprovedToOffer < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :approved, :boolean, default: false
    add_column :schedules, :approved, :boolean, default: false
    add_column :schedules, :rejected, :boolean, default: false
  end
end
