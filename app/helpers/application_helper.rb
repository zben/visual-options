module ApplicationHelper
    
    require 'net/http'

    def getPrice(ticker)    
    end
    
    def getOpen(ticker)
    end
    
    def getHigh(ticker)
    end
    
    def getLow(ticker)
    end
    
    def getDayChange(ticker)
    end
    
    def getDayPercentChange(ticker)
    end
    
    def getDayRange(ticker)
    end
    
    def getStockChart(ticker,period,style)
        
    end
    
    def getOptionChart(ticker,strike,type,exp)
    end
    
    def getStrikeList(ticker)
    end
    
    def getExpirationList()
    end
    

    def getSavedImageName(url)
        require 'net/http'
    
        name=(0...8).map{65.+(rand(25)).chr}.join
      
    
        Net::HTTP.start( 'http://app.quotemedia.com' ) { |http|
            resp = http.get(url)
            open( name+'.jpg', 'wb' ) { |file|
            file.write(resp.body)
            }
        }
        name+'.jpg'
    end 

    

end
