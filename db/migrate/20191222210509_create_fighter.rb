class CreateFighter < ActiveRecord::Migration[5.2]
  def change
    create_table :fighters do |t|
      t.string :name
      t.integer :health, default: 100
      t.float :bet_pot, default: 0
      t.integer :better_id
      t.integer :match_id
  end
end
end