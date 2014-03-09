# A module for editing the HTML of files being processed with dinner
module HtmlMangler

  # Find @include commands in an html document and replace them with the contents of the correct file, or else display an error in the shell and leave the @include command in place
  def self.mangle(html)
    lines = ""
    a = 0
    html[:files].each_pair do |name,path|
      lines = IO.readlines(path)
      lines.each_with_index do |line,i|
        if line =~ /^\s*<!-- @include.*/
          if File.exists?("#{Dir.pwd}/#{find_filename(line)}")
            lines[i] = File.read("#{Dir.pwd}/#{find_filename(line)}")
            a = i
          else
            puts "Error in #{name}, line #{i+1}: #{find_filename(line)} missing"
          end
        end
      end
      File.open("#{Dir.pwd}/build/#{name}", "w+") do |file|
        file.puts(lines)
      end
    end
  end

  # Take a line of an html page file and derive the name of the referenced file from it
  def self.find_filename(line)
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

end

