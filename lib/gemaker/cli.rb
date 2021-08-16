# frozen_string_literal: true

module Gemaker
  class Cli
    include Commander::Methods

    def run
      config = Gemaker::Config.new
      program :name, "Gemaker"
      program :version, "1.0.0"
      program :description, "CLI to generate Fintual engines and gems"
      define_new_cmd(config)
      run!
    end

    private

    def define_new_cmd(config)
      command("new") do |c|
        c.syntax = "gemaker new"
        c.description = "Create a new gem/engine with Fintual configuration"
        c.action do |args|
          draw_artii("Fintual gem generator")
          fill_config(args.first, config)

          if config.engine?
            Gemaker::Cmds::CreateEngine.for(config: config)
          else
            Gemaker::Cmds::CreateGem.for(config: config)
          end
        end
      end
    end

    # rubocop:disable Metrics/LineLength
    def fill_config(gem_name, config)
      config.gem_name = gem_name

      while config.gem_name.blank?
        config.gem_name = ask("El nombre de la gema es obligatorio... Por favor, ingrésalo:")
      end
      while config.gem_category.blank?
        config.gem_category = ask("Ingresa la categoría (stakeholders) de la gema:")
      end
      config.human_gem_name = ask("Ingresa el nombre 'humano' de la gema. Por ejemplo: \"#{config.human_gem_name}\":")
      config.summary = ask("Ingresa un resumen de la gema (una oración):")
      config.description = ask("Ingresa la descripción de la gema (aquí esfuérzate un poco más):")
      config.engine = agree("La gema es es un engine? Contesta 'yes' si tu gema funcionará como una extensión de Rails. Es decir, si agregará o extenderá models, controllers, etc.")

    end
    # rubocop:enable Metrics/LineLength

    def draw_artii(text)
      a = Artii::Base.new font: 'slant'
      puts a.asciify(text).light_blue
    end
  end
end
