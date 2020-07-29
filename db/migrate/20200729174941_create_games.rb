class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name 
      t.string :developer
      t.integer :release_year
      t.text :description 

      t.references :user, null: false, foreign_key: true 
      t.references :genre, null: false, foreign_key: true 
    end
  end
end