class AddPeopleTable < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :imdb_url
      t.integer :person_db_id, :unique => true
      t.timestamps
    end
  end
end
