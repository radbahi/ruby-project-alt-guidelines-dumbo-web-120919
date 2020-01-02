class CreateBetter < ActiveRecord::Migration[5.2]
  def change
    create_table :betters do |t|
      t.string :name
      t.float :bet_amount, default: 0.0
      t.string :bet_on # fighter name
      t.integer :bet_match # see what match they bet on
     end
  end
end