require 'test_helper'
module EchoEcho
  class ArtistTest < MiniTest::Test
    def test_resource_name
      assert_equal "artist", Artist.resource_name
    end
  end
end