class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :vote_rating
      t.references :user
      t.references :meal

      t.timestamps
    end
  end
end
