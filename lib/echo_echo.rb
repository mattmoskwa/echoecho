require "rest-client"
require "httparty"
require "hashie"
require "logger"
require 'json'
require 'active_support/all'
require 'byebug'
require "echo_echo/version"
require "echo_echo/configuration"


module EchoEcho
  def self.configure
    yield self.config
  end
  
  def self.config
    @config ||= Configuration.new
  end
end

RestClient.log = Logger.new STDOUT

require "echo_echo/request"
require "echo_echo/response"
require "echo_echo/dsl"
require "echo_echo/description"