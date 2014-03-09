# Dinner is a Ruby gem for HTML includes. 
#
# Author:: Dan Turkel (mailto:daturkel@gmail.com)
# Copyright:: Copyright (c) 2014 Dan Turkel
# License:: MIT License

require_relative 'dinner/version'
require_relative 'dinner/filemanager'
require_relative 'dinner/htmlmangler'
require_relative 'dinner/configmanager'
require 'find'
require 'listen'
require 'fileutils'

# This module is the primary Dinner namespace used to wrap the functionality of the rest of the app
module Dinner
    # Run Dinner
    def self.do_everything
        FileManager.init_build(FileManager.locate_html(true,ConfigManager.default[:build_folder],false),ConfigManager.default[:build_folder])
        HtmlMangler.mangle(FileManager.locate_html(false,ConfigManager.default[:build_folder],true))
    end
end
