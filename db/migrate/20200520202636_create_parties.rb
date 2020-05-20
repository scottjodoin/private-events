class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.text :details

      t.timestamps
    end
  end
end
