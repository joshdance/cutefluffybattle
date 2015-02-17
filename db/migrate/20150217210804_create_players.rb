class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :wins
      t.integer :matches
      t.float :win_percentage

      t.timestamps null: false
    end
  end
end
