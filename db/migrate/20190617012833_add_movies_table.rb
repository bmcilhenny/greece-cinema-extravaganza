class AddMoviesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :original_title
      t.string :movie_db_id, :unique => true
      t.boolean :in_greek_theatres
      t.string :poster_path
      t.timestamps
    end
  end
end
