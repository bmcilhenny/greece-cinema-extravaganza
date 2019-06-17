class AddPersonsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :persons do |t|
      t.string :first_name
      t.string :last_name
      t.string :imdb_id
      t.timestamps
    end
  end
end
