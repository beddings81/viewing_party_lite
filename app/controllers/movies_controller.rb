class MoviesController < ApplicationController

  def index
    @user = current_user
    if params[:movie_search]
      @results = MovieFacade.get_search_results(params[:movie_search])
    else
      @results = MovieFacade.top_rated_movies
    end
  end

  def show
    @user = current_user
    @movie = MovieFacade.get_details(params[:id])
  end
end
