class RemoveAndAddIndexOnCalendars < ActiveRecord::Migration[5.0]
  def change
    remove_index :calendars, :uri
    add_index :calendars, [:uri, :user_id], unique: true
  end
end
