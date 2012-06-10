class AddGroupToBoardPics < ActiveRecord::Migration
  def change
    add_column :board_pics, :group_id, :integer

  end
end
