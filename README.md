# EchoEcho

EchoEcho is a rubygem for accessing the Echo Nest API.

## Installation

Add this line to your application's Gemfile:

    gem 'echo_echo', git: 'git@github.com:mattmoskwa/echoecho'

And then execute:

    $ bundle

## Usage

This is a rubygem wrapper for the Echo Nest API. See [here]( http://developer.echonest.com/docs/v4 ).

To make requests to the API, you'll need to set up a develop account and get developer keys. Once you have these, set them up by including an `echonest.rb` configuration file, like so:

```
EchoEcho.configuration do |config|
  config.api_key = "your-api-key"
  config.consumer_key = "your-consumer-key"
  config.shared_secret = "your-shared-secret"
end
```

In Ruby on Rails, this file generally goes in your `config/initializers` directory.

To run the test suite against the Echo Nest API, you can also use the included `config/echonest.yml.sample` file. See that file for details.

To use, simply require the gem, and follow the convention that classes are top-level namespaces, like Artist, and Genre,
and methods are class methods on those classes. For example, to get Artist biographies:

```ruby
biographies = EchoEcho::Artist.biographies(name: "weezer").biographies
```

Results are returned in JSON format, which are parsed in to ruby hashes and wrapped in Hashie::Mash objects,
which define accessors for all the hash keys.

```ruby
raw_value = { "biographies": [{"text"=>"FOLLOW US MORE VIDEOS", "site"=>"myspace", "url"=>"http://www.myspace.com/weezer#biography", "license"=>{"type"=>"unknown", "attribution"=>"n/a", "attribution-url"=>"http://www.myspace.com/weezer#biography", "url"=>"n/a", "version"=>"n/a"}, "truncated"=>true}]}
mash = Hashie::Mash.new(raw_values)
mash.biographies.first.text #=> "FOLLOW US MORE VIDEOS"
```

### DSL
EchoEcho is written using a custom DSL that decribes RESTful requests with the terms "entities" (like Artist),
and "methods" (like biographies). For example, to describe the url "/artist/biographies", and therefore the method Artist.biographies, use the following syntax:

```ruby
entity 'artist' do
  add_method 'biographies' do
    required any: [:id, :name]
    optional :results, :start
    multiple :license
  end
end
```

Note the `required`, `optional`, and `multiple` lines. Per the docs, methods have required and optional parameters. Some
required parameters are "one of x or y". To describe this limitation, use the `any: [:x, :y]` construction.

Some parameters can take multiple values. To describe this situtation, use the `multiple :x` construction. If there
is a limit to the number of values a parameter can take, use the `limit` option, as in

```ruby
entity 'artist' do
  add_method 'similar' do
    # ...
    multiple :bucket, :name, seed_catalog: {limit: 5}, id: {limit: 5}
  end
end
```

If a parameter can be used with any method, designate it using `global`.

```ruby
global :format
entity 'artist' do
  # ...
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/echo_echo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Todo
- Finish other entities

- Instancing, i.e

```ruby
artist = Artist.search(name: "weezer").first
artist.class #=> EchoEcho::Artist
artist.id #=> "AR633SY1187B9AC3B9"
artist.biographies #=> etc
```

- Callbacks

- Error handling

- Rate-limiting

- Format (currently only JSON works)

- IDs/id spaces

- Break entities up into own files, i.e. artist.rb, genre.rb

- Add :only option to `multiple` method (i.e. for bucket)
```
multiple bucket: {only: [:audio_summary, :artist_discovery, ...]}
```