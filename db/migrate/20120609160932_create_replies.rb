class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :text

      t.timestamps
    end
  end
end
