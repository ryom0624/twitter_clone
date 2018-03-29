class TweetsController < ApplicationController
  before_action :require_user_logged_in
  before_action :currect_user,only: [:destroy]
  
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "Tweetが投稿されました。"
      redirect_to root_url
    else
      @tweets = current_user.tweets.order("created_at desc").page(params[:page])
      flash.now[:danger] = "Tweetに失敗しました。"
      render "toppages/index"
    end
  end

  def destroy
    @tweet.destroy
    flash[:success] = "Tweetが削除されました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:content)
  end
  
  def currect_user
    @tweet = current_user.tweets.find_by(id: params[:id])
    unless @tweet
      redirect_to root_url
    end
  end
end
