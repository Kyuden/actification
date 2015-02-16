require 'rails/generators/active_record'

module Actification
  module Generators
    class MigrationGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      argument :name, type: :string, default: 'create_actifications'

      def generate_files
        migration_template 'migration.rb', "db/migrate/#{name}.rb"
      end
    end
  end
end
