# A module for locating files and creating the build folder
module FileManager

  # Find the html files and return a hash containing an array of page files (:files) and an array of include files (:includes)
  def self.locate_html(with_includes,in_build = false)
    html = { :files => {}}
    if with_includes
      html[:includes] = {}
    end
    if in_build
      dir = "#{Dir.pwd}/#{ConfigManager.config[:build_folder]}"
    else
      dir = Dir.pwd
    end
    Find.find(dir) do |path|
      if FileTest.directory?(path)
        if (File.basename(path) == ConfigManager.config[:build_folder]) && !in_build
          Find.prune
        else
          next
        end
      else
        if path =~ /.*\/[^_][^\/]*\.html$/
          html[:files][File.basename(path)] = path
        elsif path =~ /.*\/[_][^\/]*\.html$/ and with_includes
          html[:includes][(File.basename(path)[1..-1])] = path
        end
      end
    end
    return html
  end

  # Create the build folder if it does not exist. If it does exist, prunes it of old files. Then it moves in the unprocessed page-files.
  # @TODO: Split this into two functions, one to create the build folder if it doesn't exist, and one to delete files which will be replaced
  def self.init_build(html)
    if Dir.exists?(ConfigManager.config[:build_folder])
      Find.find("#{Dir.pwd}/#{ConfigManager.config[:build_folder]}") do |path|
        File.delete(path) if File.extname(path) == ".html"
      end
    else
      Dir.mkdir "#{Dir.pwd}/#{ConfigManager.config[:build_folder]}"
    end
    self.push_files(html)
  end

  def self.push_files(html)
    html[:files].each_value do |path|
      FileUtils.cp(path,"#{Dir.pwd}/#{ConfigManager.config[:build_folder]}")
    end
  end

end

