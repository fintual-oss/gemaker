require "active_support/all"
require "artii"
require "commander"
require "colorize"
require "require_all"
require "power-types"

require "gemaker/version"

module Gemaker
  class Error < StandardError; end

  require_rel "gemaker/config.rb"
  require_rel "gemaker/cmds/base.rb"
  require_rel "gemaker/cmds/*.rb"
  require_rel "gemaker/cli.rb"
end
