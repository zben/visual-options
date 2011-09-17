class Stock < ActiveRecord::Base
  has_many :ranks
  belongs_to :industry
end
