require 'rho/rhocontroller'
require 'helpers/browser_helper'

class YoutubeController < Rho::RhoController
  include BrowserHelper

  # GET /Youtube
  def index
    @youtubes = Youtube.find(:all)
    render :back => '/app'
  end

  # GET /Youtube/{1}
  def show
    @youtube = Youtube.find(@params['id'])
    if @youtube
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Youtube/new
  def new
    @youtube = Youtube.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Youtube/{1}/edit
  def edit
    @youtube = Youtube.find(@params['id'])
    if @youtube
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Youtube/create
  def create
    @youtube = Youtube.create(@params['youtube'])
    redirect :action => :index
  end

  # POST /Youtube/{1}/update
  def update
    @youtube = Youtube.find(@params['id'])
    @youtube.update_attributes(@params['youtube']) if @youtube
    redirect :action => :index
  end

  # POST /Youtube/{1}/delete
  def delete
    @youtube = Youtube.find(@params['id'])
    @youtube.destroy if @youtube
    redirect :action => :index  
  end
    def search
    end
    def search_result
        you_tube_url = "http://gdata.youtube.com/feeds/api/videos?q=" + @params['name'] + "&max-results=5&v=2&alt=jsonc"
        @youtubes=	Rho::AsyncHttp.get(
                                       :url => you_tube_url
                                       )["body"]["data"]["items"]
        end
    
end
