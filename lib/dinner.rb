require_relative 'dinner/version'
require_relative 'dinner/filemanager'
require_relative 'dinner/htmlmangler'
require_relative 'dinner/configmanager'
require 'find'
require 'listen'
require 'fileutils'

module Dinner
    def self.loop
    end

    def self.do_everything
        FileManager.init_build(FileManager.locate_html(true,ConfigManager.default[:build_folder],false),ConfigManager.default[:build_folder])
        HtmlMangler.mangle(FileManager.locate_html(false,ConfigManager.default[:build_folder],true))
    end
end
