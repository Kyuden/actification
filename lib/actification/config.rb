module Actification
  class Config
    attr_accessor :cleaner

    def initialize
      @cleaner = false
    end

    def include(mod)
      Actification::Base.include(mod)
    end
  end
end
