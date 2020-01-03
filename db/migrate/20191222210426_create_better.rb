class CreateBetter < ActiveRecord::Migration[5.2]
  def change
    create_table :betters do |t|
      t.string :name
      t.float :bet_amount, default: 0.0
      t.string :bet_on # fighter name
      t.integer :fighter_id
      t.integer :match_id
     end
  end
end