module Actification
  class Model < ActiveRecord::Base
    self.table_name = "actifications"

    scope :read,      -> { where(read: true) }
    scope :unread,    -> { where(read: false) }
    scope :to,        -> (usre_id) { where(to: user_id)}
    scope :from,      -> (usre_id) { where(from: user_id)}
    scope :unread_by, -> (user_id) { unread.to(user_id) }
    scope :read_by,   -> (user_id) { read.to(user_id) }
    scope :newly,     -> { order(id: :desc) }

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
