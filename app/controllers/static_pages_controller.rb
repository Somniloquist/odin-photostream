class StaticPagesController < ApplicationController
  require "flickraw"
  FlickRaw.api_key = ENV["FLICKRAW_API_KEY"]
  FlickRaw.shared_secret = ENV["FLICKRAW_SHARED_SECRET"]

  def home
    @flickr = FlickRaw::Flickr.new
    if params[:search]
      begin
        @photos = flickr.people.getPublicPhotos(api_key: FlickRaw.api_key, user_id: search_params[:id])
      rescue
        flash.now[:danger] = "User not found"
        render :home
      end
    end
  end

  private
    def search_params
      params.require(:search).permit(:id)
    end

end
