class Api::V1::UrlsController < ActionController::API
  def index
    @urls = Url.order(visit_count: :desc).limit(10)
    render json: @urls
  end
end