# frozen_string_literal: true

module Gemaker
  module Cmds
    class CreateEngine < Gemaker::Cmds::Base
      private

      def create_gem
        add_app_related
        add_active_admin_related
        add_bin_related
        add_config_related
        add_lib_related
        add_spec_related
        add_root_related
      end

      def add_app_related
        add_app_empty_directories
        add_mailer_related
        add_models_related
        add_controllers_related
        add_jobs_related
      end

      def add_bin_related
        copy_template("engine/bin/rails", "bin/rails")
      end

      def add_config_related
        copy_template("engine/config/routes.rb", "config/routes.rb")
      end

      def add_lib_related
        extend_active_admin_config
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
        add_dummy_app_folder
        add_dummy_bin_folder
        add_dummy_public_folder
      end

      def add_root_related
        add_git_ignore
        add_gemspec
        add_gemfile
        add_rakefile
        add_readme
        add_rspec
      end

      def add_active_admin_related
        add_empty_directory("admin")
        add_empty_directory("app/views/admin")
      end

      def add_app_empty_directories
        add_empty_directory("app/decorators/#{gem_name}")
        add_empty_directory("app/observers/#{gem_name}")
        add_empty_directory("app/services/#{gem_name}")
        add_empty_directory("app/commands/#{gem_name}")
        add_empty_directory("app/values/#{gem_name}")
      end

      def add_mailer_related
        copy_template(
          "engine/app/mailers/application_mailer.rb",
          "app/mailers/#{gem_name}/application_mailer.rb"
        )
        add_empty_directory("app/views/#{gem_name}")
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

      def extend_active_admin_config
        copy_template("engine/lib/activeadmin_config.rb", "lib/#{gem_name}/activeadmin_config.rb")
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

      def add_dummy_public_folder
        copy_folder_recursevely("engine/spec/dummy/public", "spec/dummy/public")
      end
    end
  end
end
