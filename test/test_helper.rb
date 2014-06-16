require 'rubygems'
require "echo_echo"
require 'minitest/autorun'
require 'minitest/unit'

require 'minitest/pride'

EchoEcho.configure do |config|
  conf_file = File.expand_path("../../config/echonest.yml", __FILE__)
  unless File.exists? conf_file
    raise "Can't find echonest keys. Please include them in config/echonest.yml"
  else
    conf = YAML.load_file(conf_file)
  end
  config.api_key = conf["api_key"]
  config.consumer_key = conf["consumer_key"]
  config.shared_secret = conf["shared_secret"]
end