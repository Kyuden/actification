module Actification
  class Base
    class << self
      def method_missing(method_name, *args)
        if public_instance_methods(false).include?(method_name)
          new.send(method_name, *args)
        else
          super
        end
      end
    end

    def actice(attr={})
      Model.create_actification(attr)
    end
  end
end
