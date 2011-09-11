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
   "%08d" % (price*1000)
  end 
end
