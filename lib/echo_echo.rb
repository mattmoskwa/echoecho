require "echo_echo/version"
require "echo_echo/names"
require "echo_echo/request"
require "echo_echo/response"
require "echo_echo/artist"

require "rest-client"
require "hashie"
require "logger"
require 'json'
module EchoEcho
  # Your code goes here...
end

RestClient.log = Logger.new STDOUT