module Actification
  class Model < ActiveRecord::Base
    self.table_name = "actifications"

    class << self
      def create_actification(attr)
        Array(attr[:to]).each do |user_id|
          create(to:       user_id,
                 from:     attr[:from],
                 body:     attr[:body],
                 link_url: attr[:link_url])
        end
      end
    end
  end
end
