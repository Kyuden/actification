module Actification
  module Generators
    class ActificationGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      argument :method_names, type: :array, default: []

      def create_uploader_file
        template "actification.rb", File.join('app/actifications', class_path, "#{file_name}_actification.rb")
      end
    end
  end
end
