class AddUserToBoardPics < ActiveRecord::Migration
  def change
    add_column :board_pics, :user_id, :integer

  end
end
