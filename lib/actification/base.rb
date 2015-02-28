require 'active_support/core_ext/class'

module Actification
  class Base
    class_attribute :default_params
    self.default_params = {}

    class << self
      def method_missing(method_name, *args)
        if public_instance_methods(false).include?(method_name)
          new.send(method_name, *args)
        else
          super
        end
      end

      def default(value=nil)
        self.default_params = default_params.merge(value) if value
        default_params
      end
    end

    def actice(attr={})
      Model.create_actification(default_params.merge(attr))
    end
  end
end
