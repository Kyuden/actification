module Actification
  class Config
    attr_accessor :cleaner

    def initialize
      @cleaner = false
    end
  end
end
