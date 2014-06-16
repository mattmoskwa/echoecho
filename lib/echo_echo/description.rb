module EchoEcho
  module Description
    include DSL
    
    entity 'artist' do
      add_method 'biographies' do
        requires any: [:id, :name]
        optional :results, :start
        multiple :license
      end
      
      add_method 'blogs' do
        requires any: [:id, :name]
        optional :results, :start, :high_relevance
      end
      
      add_method 'list_terms' do
        optional :type
      end
      
      add_method 'familiarity' do
        requires any: [:id, :name]
      end
      
      add_method 'hotttnesss' do
        requires any: [:id, :name]
        optional :type
      end
      
      add_method 'images' do
        requires any: [:id, :name]
        optional :results, :start
        multiple :license
      end
      
      add_method 'news' do
        requires any: [:id, :name]
        optional :results, :start, :high_relevance
      end
      
      add_method 'profile' do
        requires any: [:id, :name]
        multiple :bucket
      end
      
      add_method 'reviews' do
        requires any: [:id, :name]
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
        requires any: [:name, :id]
        optional :results, :start
      end
      
      add_method 'similar' do
        requires any: [:id, :name]
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
        requires any: [:id, :name]
      end
      
      add_method 'top_hottt' do
        optional :results, :start, :limit
        multiple :genre, :bucket, :limit
      end
      
      add_method 'top_terms' do
        optional :results
      end
      
      add_method 'twitter' do
        requires any: [:id, :name]
      end
      
      add_method 'urls' do
        requires any: [:id, :name]
      end
      
      add_method 'video' do
        requires any: [:id, :name]
        optional :results, :start
      end
    end
    
    entity 'genre' do
      add_method 'artists' do
        requires :name
        optional :bucket, :limit
      end
    end
  end
end