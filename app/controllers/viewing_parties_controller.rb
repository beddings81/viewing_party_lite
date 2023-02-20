class ViewingPartiesController < ApplicationController
  before_action :validate_login, only: :new

  def new
    @users = User.where('id != ?', current_user.id)
    @user = current_user
    @runtime = params[:runtime]
    @movie = Movie.create!(api_id: params[:movie_id], image_url: params[:image_url], title: params[:title])
  end

  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    @users = User.where('id != ?', current_user.id)
    @user = current_user
    @movie = params[:movie_id]

    if viewing_party.duration && viewing_party.duration < params[:runtime].to_i
      flash[:notice] = "Error: Duration must be equal to or greater than the movie runtime"
      @runtime = params[:runtime]
      redirect_to new_viewing_party_path(params: {runtime: @runtime})
    elsif viewing_party.save(viewing_party_params)
      Invitee.create!(user_id: current_user.id, viewing_party_id: viewing_party.id, host: true)
      @users.each do |user|
        if params[user.email] == '1'
          Invitee.create!(user_id: user.id, viewing_party_id: viewing_party.id, host: false)
        end
      end
      redirect_to dashboard_index_path
    else
      flash[:notice] = "Error: All fields must be completed"
      @runtime = params[:runtime]
      redirect_to new_viewing_party_path(params: {runtime: @runtime})
    end
  end

  private
  def viewing_party_params
    params.permit(:duration, :when, :start_time, :movie_id)
  end
end
