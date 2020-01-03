class CreateMatch < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :fighter_one
      t.string :fighter_two
      t.integer :better_id
      t.integer :fighter_id
      t.float :bet_pool, default: 0
      t.string :winner
      t.string :loser
  end
end
end