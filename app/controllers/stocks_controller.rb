class StocksController < ApplicationController

  def show
    @ticker_changed = session[:ticker] != params[:ticker]
    session[:ticker] = (params[:ticker] || "SPY").upcase
    @duration_changed = session[:duration] != params[:duration]
    session[:duration] =  (params[:duration] || ["5d"])[0]
    session[:option_type]=(params[:option_type] || ["P"])[0]
    session[:manual_strike]=params[:manual_strike]
    session[:strike]= (session[:manual_strike]== "Manual" || !params[:strike_list].present?) ? (params[:strike] || 100) : params[:strike_list][0] 
    session[:expiration]=(params[:expiration] || ["110917"])[0]

    @option=Chart.save_image(session[:ticker],
                                session[:duration],
                                session[:expiration],
                                session[:strike],
                                session[:option_type])

    @stock=Chart.save_image(session[:ticker],
                                session[:duration])

    respond_to do |format|
      format.html 
      format.js 
    end
  end
  
  def show_ranking
    @ranks = Stock.where(:ticker=>params[:ticker].upcase)[0].ranks
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
