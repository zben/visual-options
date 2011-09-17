class ChangeDateFormatInRanks < ActiveRecord::Migration
  def self.up
   change_column :ranks, :date, :date
  end

  def self.down
   change_column :ranks, :date, :datetime
  end
end


