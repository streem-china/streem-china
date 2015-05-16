class SearchController < ApplicationController
  GOOGLE_SEARCH_URL = 'https://www.google.com/search?q=site:streem-china.org+%s&gws_rd=ssl'

  def show
    redirect_to(GOOGLE_SEARCH_URL % params[:q])
  end
end
