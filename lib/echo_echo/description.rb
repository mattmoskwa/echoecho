module EchoEcho
  module Description
    include DSL

    global :format, :callbacks

    entity 'artist' do
      add_method 'biographies' do
        required any: [:id, :name]
        optional :results, :start
        multiple :license
      end

      add_method 'blogs' do
        required any: [:id, :name]
        optional :results, :start, :high_relevance
      end

      add_method 'list_terms' do
        optional :type
      end

      add_method 'familiarity' do
        required any: [:id, :name]
      end

      add_method 'hotttnesss' do
        required any: [:id, :name]
        optional :type
      end

      add_method 'images' do
        required any: [:id, :name]
        optional :results, :start
        multiple :license
      end

      add_method 'news' do
        required any: [:id, :name]
        optional :results, :start, :high_relevance
      end

      add_method 'profile' do
        required any: [:id, :name]
        multiple :bucket
      end

      add_method 'reviews' do
        required any: [:id, :name]
        optional :results, :start
      end

      add_method 'search' do
        optional :limit, :artist_location,
        :name, :rank_type, :fuzzy_match, :max_familiarity, :min_familiarity, :max_hotttnesss, :min_hotttnesss,
        :artist_start_year_before, :artist_end_year_before, :artist_end_year_after, :sort, :results, :start
        multiple :bucket, :genre, :style, :mood
      end

      add_method 'extract' do
        optional :results, :bucket, :limit, :text, :max_familiarity, :min_familiarity,
        :max_hotttness, :min_hotttnesss, :sort, :results
        warn :beta
      end

      add_method 'songs' do
        required any: [:name, :id]
        optional :results, :start
      end

      add_method 'similar' do
        required any: [:id, :name]
        optional :results, :min_results, :start, :max_familiarity, :min_familiarity, :max_hotttnesss, :min_hotttnesss,
        :artist_start_year_before, :artist_end_year_before, :artist_end_year_after, :limit
        multiple :bucket, :name, seed_catalog: {limit: 5}, id: {limit: 5}
      end

      add_method 'suggest' do
        optional :results, :name, :q
        warn :beta
      end

      add_method 'terms' do
        optional :sort
        required any: [:id, :name]
      end

      add_method 'top_hottt' do
        optional :results, :start, :limit
        multiple :genre, :bucket, :limit
      end

      add_method 'top_terms' do
        optional :results
      end

      add_method 'twitter' do
        required any: [:id, :name]
      end

      add_method 'urls' do
        required any: [:id, :name]
      end

      add_method 'video' do
        required any: [:id, :name]
        optional :results, :start
      end
    end

    entity 'genre' do
      add_method 'artists' do
        required :name
        optional :limit
        multiple :bucket
      end

      add_method 'list' do
        multiple :bucket
      end

      add_method 'profile' do
        required :name
        multiple :bucket
      end

      add_method 'search' do
        optional :results, :start, :name
        multiple :bucket
      end

      add_method 'similar' do
        optional :name, :results, :start
        multiple :bucket
      end
    end

    entity 'song' do
      add_method 'search' do
        optional :title, :artist, :combined, :rank_type, :artist_id,
        :results, :start, :max_tempo, :min_tempo, :max_duration,
        :min_duration, :max_loudness, :min_loudness, :artist_max_familiarity,
        :artist_min_familiarity, :artist_start_year_before, :artist_start_year_after,
        :artist_end_year_before, :artist_end_year_after, :song_max_hotttnesss,
        :song_min_hotttnesss, :artist_max_hotttnesss, :artist_min_hotttnesss,
        :min_longitude, :max_longitude, :min_latitude, :max_latitude,
        :max_danceability, :min_danceability, :max_energy, :min_energy,
        :max_liveness, :min_liveness, :max_speechiness, :min_speechiness,
        :max_acousticness, :min_acousticness, :mode, :key, :sort, :limit
        multiple :description, :style, :mood, :song_type, :bucket
      end

      add_method 'profile' do
        required any: [:id, :track_id]
        multiple :bucket
        optional :limit
      end

      add_method 'identify' do
        optional :query, :code, :artist, :title, :release, :duration, :genre, :version
        multiple :bucket
      end
    end
  end
end