module ApplicationHelper
    
    require 'net/http'
    
    DURATION={
      "1 day"=>"1d",
      "2 day"=>"2d",
      "5 day"=>"5d",
      "10 day"=>"10d",
      "1 month"=>"1m",
      "3 month"=>"3m",
      "6 month"=>"6m"
    }
    
    OPTION_TYPE={"Call"=>"C","Put"=>"P"}
    
    CHART_HEIGHT= 300
    CHART_WIDTH= 900
    
    
    def duration_select()
      DURATION
    end
    
    def option_type()
      OPTION_TYPE
    end

    def expiration_list()
      session[:expiration_list]=nil
      if session[:expiration_list].nil?
        session[:expiration_list]={}
        for i in 0..3 do 
          date = Chronic.parse("3rd saturday in #{i.month.since.strftime('%B')}")
          session[:expiration_list][date.stamp('Sat, Sep 16, 2011').to_s] = date.stamp('99/01/31').gsub('/','')
        end
        weekly1 = Chronic.parse("this friday")
        session[:expiration_list][weekly1.stamp('Fri, Sep 16, 2011').to_s] = weekly1.stamp('99/01/31').gsub('/','')
        weekly2=Chronic.parse("last friday")
        session[:expiration_list][weekly2.stamp('Fri, Sep 16, 2011').to_s] = weekly2.stamp('99/01/31').gsub('/','')
      end
      session[:expiration_list]
    end
          
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
    

 
    

end
