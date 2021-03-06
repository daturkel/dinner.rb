# A module for editing the HTML of files being processed with dinner
module HtmlMangler

  # Find @include commands in an html document and replace them with the contents of the correct file, or else display an error in the shell and leave the @include command in place
  def self.insert_includes(html)
    a = 0
    html[:files].each_pair do |name,path|
      lines = IO.readlines(path)
      lines.each_with_index do |line,i|
        if line =~ /^\s*<!-- @include.*/
          if File.exists?("#{Dir.pwd}/#{parse_filename(line)}")
            lines[i] = File.read("#{Dir.pwd}/#{parse_filename(line)}")
            a = i
          else
            puts "Error in #{name}, line #{i+1}: #{parse_filename(line)} missing"
          end
        end
      end
      File.open("#{Dir.pwd}/#{ConfigManager.config[:build_folder]}/#{name}","w+") do |file|
        file.puts(lines)
      end
    end
  end

  # Take a line of an html page file and derive the name of the referenced file from it
  def self.parse_filename(line)
    clean_line = line.dup
    clean_line.slice!("<!-- @include")
    clean_line.slice!("-->")
    clean_line.strip!
    if clean_line.include?(".html")
      return clean_line
    else
      return clean_line + ".html"
    end
  end

  # Replace variables
  def self.insert_variables(html)
    a = 0
    html[:files].each_pair do |name,path|
      lines = IO.readlines(path)
      lines.each_with_index do |line,i|
        if line =~ /^\s*<!-- \$.*/
          # @TODO figure out how best to pick out those variable names
        end
      end
    end
  end

  # Auto-insert placeholder images
  def self.insert_placeholders(html)
    html[:files].each_pair do |name,path|
      lines = IO.readlines(path)
      lines.each_with_index do |line,i|
        while line =~ /.*<!-- @placeholder.*/
          info = parse_placeholder(line.match(/<!--[^>]*?-->/)[0])
          line = line.sub(/<!--[^>]*?-->/,"<img src=\"http://placehold.it/#{info[:res]}\">")
          lines[i] = line
        end
      end
      File.open("#{Dir.pwd}/#{ConfigManager.config[:build_folder]}/#{name}","w+") do |file|
        file.puts(lines)
      end
    end
  end

  def self.parse_placeholder(line)
    info = {}
    info[:res] = line.match(/\d*x\d*/)[0]
    info
  end

end

