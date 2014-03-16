# Dinner is a Ruby gem for HTML includes.
#
# Author:: Dan Turkel (mailto:daturkel@gmail.com)
# Copyright:: Copyright (c) 2014 Dan Turkel
# License:: MIT License

require_relative 'dinner/version'
require_relative 'dinner/filemanager'
require_relative 'dinner/htmlmangler'
require_relative 'dinner/configmanager'
require 'fileutils'
require 'find'
require 'listen'
require 'yaml'

# This module is the primary Dinner namespace used to wrap the functionality of the rest of the app
module Dinner

  # Run Dinner
  def self.do_everything
    ConfigManager.init_config
    FileManager.init_build(FileManager.locate_html(true,false))
    HtmlMangler.insert_includes(FileManager.locate_html(false,true))
    HtmlMangler.insert_placeholders(FileManager.locate_html(false,true))
  end

end

Dinner.do_everything
