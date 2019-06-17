class PersonCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :person_crews do |t|
      t.integer :person_id, null: false
      t.integer :crew_id, null: false
      t.string :department
      t.string :job
      t.timestamps
    end
  end
end
