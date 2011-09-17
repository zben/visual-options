class StocksController < ApplicationController
  include ApplicationHelper
  
  def show
    @ticker_changed = session[:ticker] != params[:ticker]
    session[:ticker] = (params[:ticker] || session[:ticker] || "SPY").upcase
    @duration_changed = session[:duration] != params[:duration]
    session[:duration] = params[:duration].nil? ? session[:duration] || "5d" : params[:duration][0]
    session[:option_type]=params[:option_type].nil? ? session[:option_type] || "P" : params[:option_type][0]
    session[:manual_strike]=params[:manual_strike]
    session[:strike]= (session[:manual_strike]== "Manual" || !params[:strike_list].present?) ? 
      (params[:strike] || session[:strike] || Chart.get_strike_prices(session[:ticker]).values[5]) : params[:strike_list][0] 
    session[:expiration]= params[:expiration].nil? ? session[:expiration] || expiration_list.values[0] : params[:expiration][0]

    @option=Chart.save_image(session[:ticker],
                                session[:session_id],
                                session[:duration],
                                session[:expiration],
                                session[:strike],
                                session[:option_type])

    @stock=Chart.save_image(session[:ticker],
                                session[:session_id],
                                session[:duration])

    respond_to do |format|
      format.html 
      format.js 
    end
  end
  
  def show_many
    @ticker_changed = session[:ticker] != params[:ticker]
    session[:ticker] = (params[:ticker] || "SPY").upcase
    @duration_changed = session[:duration] != params[:duration]
    session[:duration] =  (params[:duration] || ["5d"])[0]
    session[:option_type]=(params[:option_type] || ["P"])[0]
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
    @ticker=params[:ticker].upcase
    @ranks = Stock.where(:ticker=>@ticker)[0].ranks
  end

  def retrieve
    File.open("tmp/#{params[:file_name]}.png", 'rb') do |f|
      send_data f.read, :type => "image/png", :disposition => "inline"
    end
  end

  def options
  end

    

  def load_strike_list
    render 'shared/_strike_list', :layout=>false
  end

end
