class AddFlagToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :flagged, :boolean
    add_column :players, :flagged_by_user_id, :integer
  end
end
