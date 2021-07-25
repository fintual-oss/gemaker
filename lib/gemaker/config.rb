# frozen_string_literal: true

module Gemaker
  class Config
    attr_accessor :gem_name, :gem_category, :summary, :engine
    attr_writer :human_gem_name, :description

    def initialize
      self.engine = :normal
    end

    def human_gem_name
      return gem_name.titleize if @human_gem_name.blank?

      @human_gem_name
    end

    def gem_class
      gem_name.camelize
    end

    def description
      return summary if @description.blank?

      @description
    end

    def gem_directory
      gem_type.pluralize
    end

    def gem_type
      engine? ? 'engine' : 'gem'
    end

    def engine?
      !!engine
    end

    def gem_path
      return File.join(gem_directory, gem_name) unless gem_category

      File.join(gem_directory, gem_category, gem_name)
    end

    def relative_path_to(path)
      gem_root_path = File.join(Dir.pwd, gem_path)
      gem_complete_path = Pathname.new(gem_root_path)
      base_path = Pathname.new(gem_root_path[/^.*engines/])
      relative_path = base_path.relative_path_from(gem_complete_path)

      "#{relative_path}/#{path}"
    end
  end
end
