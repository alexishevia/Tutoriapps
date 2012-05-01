class AddUserIdToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :user_id, :integer

  end
end
