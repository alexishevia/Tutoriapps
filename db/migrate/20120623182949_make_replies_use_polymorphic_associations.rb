class MakeRepliesUsePolymorphicAssociations < ActiveRecord::Migration
  def change
    add_column :replies, :post_type, :string
  end
end
