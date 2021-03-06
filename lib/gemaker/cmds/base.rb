# frozen_string_literal: true

module Gemaker
  module Cmds
    class Base < PowerTypes::Command.new(:config)
      delegate :human_gem_name, :gem_name, :gem_directory, :gem_type, :gem_category,
               to: :config, prefix: false, allow_nil: false

      CIRCLECI_CONFIG_YAML_PATH = ".circleci/config.yml"

      def perform
        show_creating_gem_msg
        create_gem
        add_initializer
        add_to_circleci if circleci_integrated?
        execute_bundle
        execute_gem_bundle
      end

      private

      def create_gem
        raise "Not implemented"
      end

      def config
        @config
      end

      def show_creating_gem_msg
        info("Creating #{human_gem_name} #{gem_type}")
      end

      def add_readme
        copy_template("shared/README.md", "README.md")
      end

      def add_initializer
        copy_template(
          "shared/initializer.rb",
          "config/initializers/#{gem_name}.rb",
          root_destination: true
        )
      end

      def execute_bundle
        execute("bundle install", "error running bundle install")
      end

      def execute(cmd, error_message = nil)
        system cmd
        error(error_message) if $?.exitstatus != 0
      end

      def execute_gem_bundle
        execute_within_gem(
          "bundle config force_ruby_platform true --local",
          "error setting ruby platform"
        )
        execute_within_gem(
          "bundle install",
          "error running bundle install"
        )
      end

      def execute_within_gem(cmd, error_message = nil)
        Bundler.with_unbundled_env do
          system "(cd #{gem_root_path} && #{cmd})"
        end

        error(error_message) if $?.exitstatus != 0
      end

      def copy_template(source, destination, root_destination: false, executable: false)
        info("Adding #{destination}")
        template_path = "#{get_template_path(source)}.erb"
        destination_path = get_destination_path(destination, root_destination: root_destination)

        input = File.open(template_path)
        output = File.open(destination_path, "w+")
        output.write(parse_erb(input.read, config: config))
        output.close
        input.close
        File.chmod(0o744, destination_path) if executable
      end

      def parse_erb(content, data)
        b = binding
        data.each { |k, v| singleton_class.send(:define_method, k) { v } }
        ERB.new(content, nil, "-").result(b)
      end

      def copy_file(source, destination)
        info("Adding #{destination}")
        ::FileUtils.cp(get_template_path(source), get_destination_path(destination))
      end

      def copy_folder_recursevely(source, destination)
        info("Adding #{destination} folder and contents")
        ::FileUtils.cp_r(get_template_path(source), get_destination_path(destination))
      end

      def get_destination_path(destination, root_destination: false)
        base_path = root_destination ? app_root_path : gem_root_path
        destination_path = File.join(base_path, destination)
        ::FileUtils.mkdir_p(File.dirname(destination_path))
        destination_path
      end

      def get_template_path(file_path)
        File.join(templates_path, file_path)
      end

      def templates_path
        File.expand_path("../../gemaker/templates", __dir__)
      end

      def gem_root_path
        File.join(app_root_path, @config.gem_path)
      end

      def app_root_path
        Dir.pwd
      end

      def info(string)
        puts string.to_s.green
      end

      def error(string)
        return if string.blank?

        puts string.to_s.red
      end

      def add_to_circleci
        info("Adding #{gem_type} to CircleCI config")

        config_yaml = File.readlines CIRCLECI_CONFIG_YAML_PATH

        new_entry_index = find_new_circleci_entry_index(config_yaml)
        config_yaml.insert(new_entry_index, *new_circleci_entry)

        File.open(CIRCLECI_CONFIG_YAML_PATH, "w+") do |file|
          file.puts(config_yaml)
        end
      end

      def find_new_circleci_entry_index(config_yaml)
        index = 1 + config_yaml.index("      # #{gem_type}s_specs_list_reference_for_gemaker\n")
        raise "Magic comment for #{gem_type}s specs not found in CircleCI's config" if index.nil?
        index
      end

      def new_circleci_entry
        [
          "      - run_#{gem_type}_specs:\n",
          "          path: #{gem_type}s/#{gem_category}/#{gem_name}\n"
        ]
      end

      def circleci_integrated?
        config_found = File.exist?(CIRCLECI_CONFIG_YAML_PATH)
        info("CircleCI configuration found!") if config_found
        config_found
      end
    end
  end
end
