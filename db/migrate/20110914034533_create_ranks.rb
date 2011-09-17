class CreateRanks < ActiveRecord::Migration
  def self.up
    create_table :ranks do |t|
      t.integer :stock_id
      t.float :close_price
      t.integer :volume
      t.float :sma20
      t.float :sma50
      t.float :sma200
      t.datetime :date
      t.float :industry_rank
      t.float :total_rank

      t.timestamps
    end
  end

  def self.down
    drop_table :ranks
  end
end
