require "actification/version"
require 'actification/config'

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
