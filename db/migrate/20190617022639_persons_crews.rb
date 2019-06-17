class PersonsCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :persons_crews do |t|
      t.integer :person_id, null: false
      t.integer :crew_id, null: false
      t.string :department
      t.string :position
      t.timestamps
    end
  end
end
