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
  end
end
