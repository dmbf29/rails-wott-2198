class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
    # render 'index.html.erb'
    respond_to do |format| # format => html,json,txt
      format.html { render 'index' }
      format.json { render json: @challenges }
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    @chats = @challenge.chats.where(user: current_user)
    respond_to do |format| # format => html,json,txt
      format.html { render 'show' }
      format.json { render json: @challenge }
    end
  end
end
