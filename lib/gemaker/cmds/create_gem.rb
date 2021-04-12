# frozen_string_literal: true

module Gemaker
  module Cmds
    class CreateGem < Gemaker::Cmds::Base
      private

      def create_gem
        add_bin_related
        add_lib_related
        add_root_related
      end

      def add_bin_related
        copy_file("normal/bin/setup", "bin/setup")
        copy_template("normal/bin/console", "bin/console")
      end

      def add_lib_related
        copy_template("normal/lib/dependencies.rb", "lib/#{gem_name}/dependencies.rb")
        copy_template("normal/lib/errors.rb", "lib/#{gem_name}/errors.rb")
        copy_template("normal/lib/main.rb", "lib/#{gem_name}.rb")
      end

      def add_root_related
        add_readme
        copy_template("normal/gemspec", "#{gem_name}.gemspec")
        copy_file("normal/Gemfile", "Gemfile")
        copy_template("normal/Rakefile", "Rakefile")
      end
    end
  end
end
