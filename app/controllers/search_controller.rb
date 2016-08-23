class SearchController < ApplicationController


  def index
    params[:query].to_sym
    @posts = Post.search_posts(params[:query]).paginate(page: params[:page], per_page: 20).order("created_at DESC")
  end

end
