class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :title
      t.string :author
      t.string :publisher
      t.boolean :available, :default => true, :null => false
      t.text :additional_info
      t.text :contact_info

      t.timestamps
    end
  end
end
