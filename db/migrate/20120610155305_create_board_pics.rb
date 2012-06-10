class CreateBoardPics < ActiveRecord::Migration
  def change
    create_table :board_pics do |t|
      t.has_attached_file :image
      t.timestamps
    end
  end
end
