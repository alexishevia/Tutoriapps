class AddFkToEnrollments < ActiveRecord::Migration
  def change
    add_foreign_key(:enrollments, :groups)
    add_foreign_key(:enrollments, :users)
  end
end
