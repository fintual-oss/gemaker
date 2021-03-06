# frozen_string_literal: true

module Gemaker
  module Cmds
    class CreateEngine < Gemaker::Cmds::Base
      private

      def create_gem
        add_app_related
        add_bin_related
        add_config_related
        add_lib_related
        add_spec_related
        add_root_related
      end

      def add_app_related
        add_mailer_related
        add_models_related
        add_controllers_related
        add_jobs_related
      end

      def add_bin_related
        copy_template("engine/bin/rails", "bin/rails", executable: true)
      end

      def add_config_related
        copy_template("engine/config/routes.rb", "config/routes.rb")
      end

      def add_lib_related
        extend_papertrail_engine_config
        extend_paper_trail_gem_config
        add_engine_file
        add_errors_file
        add_main_file
      end

      def add_spec_related
        add_example_spec
        add_rails_helper
        add_spec_helper
        add_dummy_app_related
      end

      def add_dummy_app_related
        add_dummy_config_related

        add_dummy_app_folder
        add_dummy_bin_folder
        add_dummy_config_ru
        add_dummy_public_folder
        add_dummy_rakefile
      end

      def add_dummy_config_related
        add_dummy_config_environments
        add_dummy_config_initializers

        add_dummy_config_application
        add_dummy_config_boot
        add_dummy_config_database
        add_dummy_config_environment
        add_dummy_config_routes
      end

      def add_root_related
        add_git_ignore
        add_gemspec
        add_gemfile
        add_rakefile
        add_readme
        add_rspec
      end

      def add_mailer_related
        copy_template(
          "engine/app/mailers/application_mailer.rb",
          "app/mailers/#{gem_name}/application_mailer.rb"
        )
      end

      def add_models_related
        copy_template(
          "engine/app/models/application_record.rb",
          "app/models/#{gem_name}/application_record.rb"
        )
      end

      def add_controllers_related
        copy_template(
          "engine/app/controllers/application_controller.rb",
          "app/controllers/#{gem_name}/application_controller.rb"
        )
      end

      def add_jobs_related
        copy_template(
          "engine/app/jobs/application_job.rb",
          "app/jobs/#{gem_name}/application_job.rb"
        )
      end

      def extend_papertrail_engine_config
        copy_template("engine/lib/papertrail_config.rb", "lib/#{gem_name}/papertrail_config.rb")
      end

      def extend_paper_trail_gem_config
        copy_template("engine/lib/paper_trail_configuration.rb", "lib/#{gem_name}/paper_trail_configuration.rb")
      end

      def add_engine_file
        copy_template("engine/lib/engine.rb", "lib/#{gem_name}/engine.rb")
      end

      def add_errors_file
        copy_template("engine/lib/errors.rb", "lib/#{gem_name}/errors.rb")
      end

      def add_main_file
        copy_template("engine/lib/main.rb", "lib/#{gem_name}.rb")
      end

      def add_example_spec
        copy_template("engine/spec/example_spec.rb", "spec/example_spec.rb")
      end

      def add_rails_helper
        copy_file("engine/spec/rails_helper.rb", "spec/rails_helper.rb")
      end

      def add_spec_helper
        copy_file("engine/spec/spec_helper.rb", "spec/spec_helper.rb")
      end

      def add_git_ignore
        copy_file("engine/.gitignore", ".gitignore")
      end

      def add_gemspec
        copy_template("engine/gemspec", "#{gem_name}.gemspec")
      end

      def add_gemfile
        copy_template("engine/Gemfile", "Gemfile")
      end

      def add_rakefile
        copy_template("engine/Rakefile", "Rakefile")
      end

      def add_rspec
        copy_file("engine/.rspec", ".rspec")
      end

      def add_dummy_app_folder
        copy_folder_recursevely("engine/spec/dummy/app", "spec/dummy/app")
      end

      def add_dummy_bin_folder
        copy_folder_recursevely("engine/spec/dummy/bin", "spec/dummy/bin")
      end

      def add_dummy_config_ru
        copy_file("engine/spec/dummy/config.ru", "spec/dummy/config.ru")
      end

      def add_dummy_public_folder
        copy_folder_recursevely("engine/spec/dummy/public", "spec/dummy/public")
      end

      def add_dummy_rakefile
        copy_file("engine/spec/dummy/Rakefile", "spec/dummy/Rakefile")
      end

      def add_dummy_config_environments
        copy_folder_recursevely(
          "engine/spec/dummy/config/environments", 
          "spec/dummy/config/environments"
        )
      end

      def add_dummy_config_initializers
        copy_folder_recursevely(
          "engine/spec/dummy/config/initializers", 
          "spec/dummy/config/initializers"
        )
      end

      def add_dummy_config_application
        copy_template(
          "engine/spec/dummy/config/application.rb",
          "spec/dummy/config/application.rb"
        )
      end

      def add_dummy_config_boot
        copy_file(
          "engine/spec/dummy/config/boot.rb",
          "spec/dummy/config/boot.rb"
        )
      end

      def add_dummy_config_database
        copy_template(
          "engine/spec/dummy/config/database.yml",
          "spec/dummy/config/database.yml"
        )
      end

      def add_dummy_config_environment
        copy_file(
          "engine/spec/dummy/config/environment.rb", 
          "spec/dummy/config/environment.rb"
        )
      end

      def add_dummy_config_routes
        copy_template(
          "engine/spec/dummy/config/routes.rb", 
          "spec/dummy/config/routes.rb"
        )
      end
    end
  end
end
