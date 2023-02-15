class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.order(visit_count: :desc).limit(10)
    @recently_created_urls = Url.where("created_at >= ?", 4.hours.ago)
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      flash[:success] = "URL successfully shortened!"
      redirect_to root_path
    else
      flash[:error] = "Invalid URL, please try again."
      redirect_to root_path
    end
  end

  def show
    @url = Url.find_by(short_url: params[:id])
    if @url
      @url.increment_visit_count
      redirect_to @url.full_url, allow_other_host: true
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end

  def redirect
    @url = Url.find_by(short_url: params[:short_url])
    if @url
      @url.increment_visit_count
      redirect_to @url.full_url, allow_other_host: true
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end

  def visit
    @url = Url.find(params[:id])
    @url.increment_visit_count
    render json: { visitCount: @url.visit_count }
  end

  private

  def url_params
    params.require(:url).permit(:full_url)
  end
end
