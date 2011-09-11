class ApplicationController < ActionController::Base
  protect_from_forgery
  
   def getSavedImageName(url)
               
      require 'net/http'
      Net::HTTP.start("app.quotemedia.com") { |http|
        resp = http.get(url)
        open("tmp/option.png", "wb") { |file|
         file.write(resp.body)
        }
      }
      
      "option.png"
    end 
    
    def topGainer()
        require 'csv'
        
        require 'net/http'
        Net::HTTP.start("finviz.com") { |http|
        resp = http.get("/export.ashx?v=111&s=ta_topgainers&f=sh_price_o10")
        open("public/images/winner.csv", "wb") { |file|
        file.write(resp.body)
        }
        }
        
       
        array=[]

        CSV.open("public/images/winner.csv",'r', ',') do |row|
            
        end
        [1,2,3]

    end
end
