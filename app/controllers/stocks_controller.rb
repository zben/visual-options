class StocksController < ApplicationController

  def change_ticker
      session[:ticker]=params[:ticker][:ticker].upcase
      redirect_to :action=>:show
  end

  def show
    $ticker=session[:ticker]
    @image_path=getSavedImageName("/quotetools/getChart?webmasterId=91004&snap=true&symbol="+session[:ticker]+"&chscale=2d&chtype=AreaChart&locale=en_US&chwid=300&chhig=300&chpccol=ff0000&chfrmon=false&chton=false&chpcon=true")  
    
  end
  
  def retrieve
    File.open('tmp/option.png', 'rb') do |f|
      send_data f.read, :type => "image/png", :disposition => "inline"
    end
  end

  def options
  end

private

    
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
