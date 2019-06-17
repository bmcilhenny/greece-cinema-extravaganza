require 'rest-client'
require 'byebug'

base_api = "https://api.themoviedb.org/3"
api_key = ENV["movie_db_api_key"]
country = "GR"
region = "&region=#{country}"
page = "&page="
movie_end_point = "/movie"
person_end_point = "/person" 
movies_now_playing_end_point = "/movie/now_playing"
poster_path = "https://image.tmdb.org/t/p/w500"

movies_array = Array
directors_array = Array
page_num = 1
base_api_query = "?api_key=#{api_key}&language=en-US"


Movie.destroy_all
Crew.destroy_all
Person.destroy_all
PersonCrew.destroy_all

now_playing_movies_resp = JSON.parse(RestClient.get(base_api + movies_now_playing_end_point + base_api_query + page + page_num.to_s + region))
movie_playing_data = now_playing_movies_resp["results"]

until now_playing_movies_resp["total_pages"] == page_num
    page_num += 1
    begin
        resp = RestClient.get(base_api + movies_now_playing_end_point + base_api_query + page + page_num.to_s + region)
        movie_playing_data << JSON.parse(resp)["results"]
        puts resp.headers[:x_ratelimit_remaining]
    rescue
        sleep(10)
        retry
    end
end

cleaned_movie_now_playing_data = movie_playing_data.flatten

threads = 1
Parallel.each(cleaned_movie_now_playing_data, in_processes: threads, progress: "Creating movies") do |movie_data|
    begin
        movie_id = movie_data["id"]
        resp = RestClient.get("#{base_api}#{movie_end_point}/#{movie_id}#{base_api_query}&append_to_response=credits")
        puts resp.headers[:x_ratelimit_remaining]
        in_depth_movie_data = JSON.parse(resp)
        movie_credits = in_depth_movie_data["credits"]
        
        movie = Movie.create(movie_db_id: movie_id, title: in_depth_movie_data["title"], description: in_depth_movie_data["overview"], original_title: in_depth_movie_data["original_title"], poster: in_depth_movie_data["poster_path"])
        crew = Crew.create(movie: movie)

        directors = in_depth_movie_data["credits"]["crew"].select{|crew_member| crew_member["department"] == "Directing" && crew_member["job"] == "Director"}
        directors.each do |director|
            person_id = director["id"]
            begin
                director_data_resp = RestClient.get("#{base_api}#{person_end_point}/#{person_id}#{base_api_query}")
                puts director_data_resp.headers[:x_ratelimit_remaining]
                director_data = JSON.parse(director_data_resp)
                person = Person.create(name: director_data["name"], imdb_id: director_data["imdb_id"], person_db_id: person_id)
                PersonCrew.create(person: person, crew: crew, department: director["department"], job: director["job"])
            rescue
                sleep(10)
                retry
            end 
        end
    rescue
        sleep(10)
        retry
    end
end