class AddOfferTypeToBooks < ActiveRecord::Migration
  def change
    add_column :books, :offer_type, :string
    add_column :books, :price, :decimal, :precision => 5, :scale => 2
  end
end