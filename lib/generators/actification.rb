require 'rails/generators/named_base'

module Actification
  # A generator module with Actification table schema.
  module Generators
    # A base module
    module Base
      # Get path for migration template
      def source_root
        @_public_actification_source_root ||= File.expand_path(File.join('../actification', generator_name, 'templates'), __FILE__)
      end
    end
  end
end
