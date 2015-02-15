# Migration responsible for creating a table with actifications
class CreateActifications < ActiveRecord::Migration
  def change
    create_table :actifications do |t|
      t.integer :to,      null: false
      t.integer :from
      t.string  :body,    null: false, limit: 512
      t.string  :link_url
      t.boolean :read,    null: false, default: false
      t.string  :type

      t.timestamps
    end

    add_index :actifications, [:read, :to]
  end
end
