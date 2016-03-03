class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  	# Get the sort mode (either title or release_date)
    @sort_mode = params[:sort_by]
    
    # Get the list of rating values from db
    @all_ratings = Movie.ratings_list
    
    # Get the list of user selected ratings
    @checked_ratings = params[:ratings]
    if !@checked_ratings then @checked_ratings = Hash.new end
    
    # Filter the movies according to selection
    if @checked_ratings.empty?
      @movies = Movie.all.order("#{@sort_mode}")
    else
      @movies = Movie.where(:rating => @checked_ratings.keys).order("#{@sort_mode}")
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
