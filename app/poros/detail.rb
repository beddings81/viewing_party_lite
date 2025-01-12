class Detail
  attr_reader :id,
              :image,
              :title,
              :vote_average, 
              :runtime, 
              :genres, 
              :overview,
              :cast, 
              :total_reviews, 
              :reviews

  def initialize(data)
    @image = "https://image.tmdb.org/t/p/original#{data[0][:poster_path]}"
    @id = data[0][:id]
    @title = data[0][:title]
    @vote_average = data[0][:vote_average]
    @runtime = data[0][:runtime]
    @genres = data[0][:genres].map do |genre|
      genre[:name]
    end
    @overview = data[0][:overview]
    @cast = {}
    data[1].each do |member|
      @cast[member[:name]] = member[:character]
    end
    @total_reviews = data[2][:total_results]
    @reviews = {}
    data[2][:results].each do |review|
      @reviews[review[:author]] = review[:content]
    end
  end
end