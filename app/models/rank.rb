class Rank < ActiveRecord::Base
  belongs_to :stock
  
  def self.download_data
    require 'csv'
    require 'open-uri'
    ActiveRecord::Base.transaction do
       CSV.new(open("http://finviz.com/export.ashx?v=152&c=1,2,4,6,52,53,54,65,66,67"), :headers => :first_row).each do |line|
       #"Ticker","Company","Industry","Market Cap","20-Day Simple Moving Average","50-Day Simple Moving Average","200-Day Simple Moving Average","Price","Change","Volume"

         industry = Industry.find_or_create_by_name(line['Industry'])
         stock = Stock.find_or_create_by_ticker(line['Ticker'],:name=>line['Company'],:industry_id=>industry.id,:capitalization=>line['Market Cap'])
         rank = Rank.create(:stock_id=>stock.id,:close_price=>line['Price'],:volume=>line['Volume'],:sma20=>line['20-Day Simple Moving Average'],:sma50=>line['50-Day Simple Moving Average'],:sma200=>line['200-Day Simple Moving Average'],:date=>Date.today,:percent_change=>line['Change'])
#         puts rank.id
          
      end         
    end
  end
  
  def self.compute_rank
    ActiveRecord::Base.transaction do
      count = Rank.today.count
      Rank.today.order('percent_change asc').each_with_index do |rank,index| 
        rank.total_rank=index/count.to_f
        rank.save!
      end
      
      Industry.all.each do |ind|
        count = ind.ranks.today.count
        ind.ranks.today.order('percent_change asc').each_with_index do |rank, index|
          rank.industry_rank=index/count.to_f
          rank.save!
        end
      end
    end 
  end
  


    
  def self.today
    on(Date.today)
  end
  
  def self.active
    where('percent_change is not null')
  end
  
  def self.on(date)
    where('date between ? and ?',date, date+1)
  end
  
  def related_rank(ticker)
    Stock.where(:ticker=>ticker)[0].ranks.on(date)[0]
  end
  
  def self.do_nothing
  end
end
