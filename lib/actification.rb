require "actification/version"
require 'actification/config'
require 'actification/base'
require 'actification/model'

module Actification
  class << self
    def config
      @config ||= Actification::Config.new
    end

    def configure(&block)
      yield(config) if block_given?
    end
  end
end
