class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @tweet = current_user.tweets.build
      @tweets = current_user.tweets.order("created_at desc").page(params[:page])
    end
  end
end
