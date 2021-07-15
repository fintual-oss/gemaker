# frozen_string_literal: true

module Gemaker
  module Cmds
    class Base < PowerTypes::Command.new(:config)
      delegate :human_gem_name, :gem_name, :gem_directory, :gem_type, :gem_category,
               to: :config, prefix: false, allow_nil: false

      def perform
        show_creating_gem_msg
        create_gem
        add_initializer
        execute_bundle
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

      def copy_template(source, destination, root_destination: false)
        info("Adding #{destination}")
        template_path = get_template_path(source) + ".erb"
        destination_path = get_destination_path(destination, root_destination: root_destination)

        input = File.open(template_path)
        output = File.open(destination_path, "w+")
        output.write(parse_erb(input.read, config: config))
        output.close
        input.close
      end

      def parse_erb(content, data)
        b = binding
        data.each { |k, v| singleton_class.send(:define_method, k) { v } }
        ERB.new(content, nil, "-").result(b)
      end

      def add_empty_directory(path)
        copy_file("shared/.gitkeep", "#{path}/.gitkeep")
      end

      def copy_file(source, destination)
        info("Adding #{destination}")
        ::FileUtils.cp(get_template_path(source), get_destination_path(destination))
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
        File.join(app_root_path, gem_directory, @config.gem_name)
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
    end
  end
end
