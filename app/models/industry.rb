class Industry < ActiveRecord::Base
  has_many :stocks
  has_many :ranks, :through=>:stocks
end
