class StocksController < ApplicationController

  def show
    session[:ticker] = (params[:ticker] || "SPY").upcase
    session[:duration] =  (params[:duration] || ["10d"])[0]
    session[:option_type]=(params[:option_type] || ["P"])[0]
    session[:manual_strike]=params[:manual_strike]
    session[:strike]= session[:manual_strike]== "Manual" ? (params[:strike] || 100) : params[:strike_list][0] 
    session[:expiration]=(params[:expiration] || ["1109017"])[0]

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
