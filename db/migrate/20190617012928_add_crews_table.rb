class AddCrewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :crews do |t|
      t.integer :movie_id, null: false
      t.timestamps
    end
  end
end
