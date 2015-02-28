module Actification
  class Model < ActiveRecord::Base
    self.table_name = "actifications"

    scope :read,      -> { where(read: true) }
    scope :unread,    -> { where(read: false) }
    scope :to,        -> (usre_id) { where(to: user_id)}
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

      def all_read_by!(user_id)
        if Actification.config.cleaner?
          unread_by(user_id).delete_all
        else
          unread_by(user_id).update_all(read: true)
        end
      end

      def all_unread_by!(user_id)
        read_by(user_id).update_all(read: false)
      end
    end

    def read!
      if Actification.config.cleaner?
        destroy!
      else
        update_attributes!(read: true)
      end
    end

    def unread!
      update_attributes!(read: false)
    end
  end
end
