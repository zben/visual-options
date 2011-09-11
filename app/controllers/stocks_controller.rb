class StocksController < ApplicationController

  def show
    session[:ticker] = (params[:ticker] || "SPY").upcase
    session[:duration] =  (params[:duration] || ["10d"])[0]
    session[:option_type]=(params[:option_type] || ["P"])[0]
    session[:strike]=params[:strike].to_f || 0 
    session[:expiration]=(params[:expiration] || ["110909"])[0]

    @option=Chart.save_image(session[:ticker],
                                session[:duration],
                                session[:expiration],
                                session[:strike],
                                session[:option_type])

    @stock=Chart.save_image(session[:ticker],
                                session[:duration])

  end
  
  def retrieve
    File.open("tmp/#{params[:file_name]}.png", 'rb') do |f|
      send_data f.read, :type => "image/png", :disposition => "inline"
    end
  end

  def options
  end

private

    



end
