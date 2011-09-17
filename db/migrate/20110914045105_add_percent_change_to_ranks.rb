class AddPercentChangeToRanks < ActiveRecord::Migration
  def self.up
    add_column :ranks, :percent_change, :float
  end

  def self.down
    remove_column :ranks, :percent_change
  end
end
