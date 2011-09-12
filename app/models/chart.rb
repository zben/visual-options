class Chart
  include ApplicationHelper
  
  def self.get_stock_url(ticker, duration, expiration, strike=100, type=nil)
    if type.nil?
            
      "/quotetools/getChart?webmasterId=91004&snap=true&symbol=#{ticker}&chscale=#{duration}&chtype=AreaChart&locale=en_US&chwid=#{CHART_WIDTH}&chhig=#{CHART_HEIGHT}&chpccol=ff0000&chfrmon=false&chton=false&chpcon=true"  
    else    
      
      "/quotetools/getChart?webmasterId=91004&snap=true&symbol=@#{ticker}%20%20%20#{expiration}#{type}#{self.getprice(strike)}&chscale=#{duration}&chtype=AreaChart&locale=en_US&chwid=#{CHART_WIDTH}&chhig=#{CHART_HEIGHT}&chpccol=ff0000&chfrmon=false&chton=false&chpcon=true"  
    end
  end
 
  def self.save_image(ticker, duration, expiration=nil, strike=nil, type=nil)
    require 'net/http'
    $file_name = type==nil ? 'stock' : 'option'
    
      url = self.get_stock_url(ticker, duration, expiration, strike, type)
      Net::HTTP.start("app.quotemedia.com") { |http|
        resp = http.get(url)
        open("tmp/#{$file_name}.png", "wb") { |file|
         file.write(resp.body)
        }
      }
      $file_name
  end
  
  def self.getprice(price)
   "%08d" % (price.to_f*1000)
  end
  
  def self.getquote(ticker)
    require 'open-uri'
    open("http://finance.yahoo.com/d/quotes.csv?s=#{ticker}&f=l1").read().to_f
  end
  
  def self.get_strike_prices(ticker)
    price = self.getquote(ticker)
    if price > 100
      Hash[*(-4..4).collect{|x| 5*(price.to_i/5)+x*5}.collect{|v| ["#{v.to_s}   (%.1f %%)" % (v*100/price-100),v]}.flatten]
    elsif price >10
      Hash[*(-4..4).collect{|x| price.to_i+x}.collect{|v| ["#{v.to_s}   (%.1f %%)" % (v*100/price-100),v]}.flatten]
    else
      Hash[*(-4..8).collect{|x| price.to_i+x*0.5}.collect{|v| ["#{v.to_s}   (%.1f %%)" % (v*100/price-100),v]}.flatten]
    end
  end  
end
