module HtmlMangler
    
    def self.mangle(html)
        lines = ""
        a = 0
        html[:files].each_pair do |name,path|
            lines = IO.readlines(path)
            lines.each_with_index do |line,i|
                if line =~ /^\s*<!-- @include.*/
                    if File.exists?(strip_filename(line))
                        lines[i] = File.read(strip_filename(line))
                        a = i
                    else
                        puts "Error in #{name}, line #{i+1}: #{strip_filename(line)} missing"
                    end
                end
            end
            File.open("build/#{name}", "w+") do |file|
                file.puts(lines)
            end 
        end
    end

    def self.strip_filename(line)
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
