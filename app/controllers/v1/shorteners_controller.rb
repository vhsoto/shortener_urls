class V1::ShortenersController < ApplicationController
  def index
    domain = URI.parse(params[:domain]).host    
    @detail = Shortener.find_by_url(domain)
    respond_to do |format|
      format.json {
        render json:{
          response: [
            {
              url: @detail.url,
              url_corta: v1_short_code_url(short_code: @detail.short_code),
              counter: @detail.counter,
              ranking: @detail.alexa_rank
            }
          ]
        }
      }
    end
  end

  def create
    request = AlexaApiService.new
    request = request.request_api(params[:url])
    ranking = request["Awis"]["Results"]["Result"]["Alexa"]["TrafficData"]["Rank"]
    @shortener = Shortener.new(shortener_params)
    @shortener.alexa_rank = ranking
    if @shortener.save
      respond_to do |format|
        format.json {
          render json: {    
            url_corta: v1_short_code_url(short_code: @shortener.short_code)
          }
        }
      end
    else
      respond_to do |format|
        format.json {
          render json: {    
            errors: @shortener.errors.as_json
          }
        }
      end
    end
  end

  def show
    @shortener = Shortener.find_by_short_code(params[:short_code])
    if @shortener.present?
      @shortener.increment!(:counter)
      redirect_to @shortener.url
    end
  end

  private

  def shortener_params
    params.require(:shortener).permit(:url)
  end
end
