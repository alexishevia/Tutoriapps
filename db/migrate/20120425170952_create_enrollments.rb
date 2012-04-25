class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.string :user_email
      t.integer :group_id

      t.timestamps
    end
  end
end
