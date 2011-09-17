class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.integer :industry_id
      t.integer :capitalization

      t.timestamps
    end
  end

  def self.down
    drop_table :stocks
  end
end
