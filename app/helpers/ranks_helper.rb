module RanksHelper
  def today_is_trading_day?
    require 'open-uri'
    date_string = open("http://finance.yahoo.com/d/quotes.csv?s=SPY&f=d1").read.strip.gsub(/\"/,"")
    begin
      Date.strptime(date_string,'%m/%d/%Y').today?
    rescue
      true
    end 
  end
end
