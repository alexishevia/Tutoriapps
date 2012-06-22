class AddClassDateToBoardPics < ActiveRecord::Migration
  def change
    add_column :board_pics, :class_date, :date

  end
end
