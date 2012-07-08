class SetLimitForTimestamps < ActiveRecord::Migration
  def up
    change_column :board_pics, :created_at, :datetime, :limit => 3
    change_column :books, :created_at, :datetime, :limit => 3
    change_column :enrollments, :created_at, :datetime, :limit => 3
    change_column :feedbacks, :created_at, :datetime, :limit => 3
    change_column :groups, :created_at, :datetime, :limit => 3
    change_column :posts, :created_at, :datetime, :limit => 3
    change_column :replies, :created_at, :datetime, :limit => 3
    change_column :users, :created_at, :datetime, :limit => 3

    change_column :board_pics, :updated_at, :datetime, :limit => 3
    change_column :books, :updated_at, :datetime, :limit => 3
    change_column :enrollments, :updated_at, :datetime, :limit => 3
    change_column :feedbacks, :updated_at, :datetime, :limit => 3
    change_column :groups, :updated_at, :datetime, :limit => 3
    change_column :posts, :updated_at, :datetime, :limit => 3
    change_column :replies, :updated_at, :datetime, :limit => 3
    change_column :users, :updated_at, :datetime, :limit => 3
  end

  def down
    change_column :board_pics, :created_at, :datetime
    change_column :books, :created_at, :datetime
    change_column :enrollments, :created_at, :datetime
    change_column :feedbacks, :created_at, :datetime
    change_column :groups, :created_at, :datetime
    change_column :posts, :created_at, :datetime
    change_column :replies, :created_at, :datetime
    change_column :users, :created_at, :datetime

    change_column :board_pics, :updated_at, :datetime
    change_column :books, :updated_at, :datetime
    change_column :enrollments, :updated_at, :datetime
    change_column :feedbacks, :updated_at, :datetime
    change_column :groups, :updated_at, :datetime
    change_column :posts, :updated_at, :datetime
    change_column :replies, :updated_at, :datetime
    change_column :users, :updated_at, :datetime
  end
end
