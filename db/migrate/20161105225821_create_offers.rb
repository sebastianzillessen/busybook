class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.references :user, foreign_key: true
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
