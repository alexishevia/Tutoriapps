class CreateGroupsUsers < ActiveRecord::Migration
  def change
    create_table :groups_users, :id => false do |t|
      t.references :group, :null => false
      t.references :user, :null => false
    end
  end
end
