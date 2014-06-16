require 'test_helper'
require 'byebug'
module EchoEcho
  class ArtistTest < MiniTest::Test
    def test_resource_name
      assert_equal "artist", Artist.resource_name
    end
    
    def test_similar
      a = Artist.similar(name: "david bowie")
      assert a.artists
    end
    
    def test_search
      artists = Artist.search(name: "weezer", fuzzy_match: true).artists
      assert artists.map(&:name).member? "Weezer"
      
      artists = Artist.search(genre: ["jazz", "rock"]).artists
      assert artists
    end
    
    def test_extract
      artists = Artist.extract(text: "Weezer is my favorite").artists
      assert artists.map(&:name).member? "Weezer"
    end
    
    def test_suggest
      artists = Artist.suggest(name: "weez").artists
      assert artists.map(&:name).member? "Weezer"
    end 
    
    def test_profile
      results = Artist.profile(name: "weezer", bucket: ["biographies", "blogs"])
      assert_equal results.artist.biographies.first, Artist.biographies(name: "weezer").biographies.first
      assert_equal results.artist.blogs.first, Artist.blogs(name: "weezer").blogs.first
    end
    
    def test_multiple_values_with_limit
      # get some artists then grab their IDs
      artists = Artist.search(genre: "rock", results: 6).artists
      # test that similar returns with < 5
      results = Artist.similar(id: artists[0..3].map(&:id))
      assert results.artists
      # now try > 5
      assert_raises ArgumentError do
        results = Artist.similar(id: artists.map(&:id))
      end
    end
    
    def test_error_conditions
      assert_raises ArgumentError do
        Artist.similar(notgood: 1)
      end
    end
  end
end