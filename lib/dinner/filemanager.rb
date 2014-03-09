module FileManager 

    def self.locate_html(with_includes,build_folder,in_build = false)
        html = { :files => {}}
        if with_includes
            html[:includes] = {} 
        end
        if in_build
            dir = "#{Dir.pwd}/#{build_folder}"
        else
            dir = Dir.pwd
        end
        Find.find(dir) do |path|
            if FileTest.directory?(path)
                if (File.basename(path) == build_folder) && !in_build
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

    def self.init_build(html,build_folder)
        if Dir.exists?(build_folder)
            Find.find("#{Dir.pwd}/#{build_folder}") do |path|
                File.delete(path) if File.extname(path) == ".html"
            end
        else 
            Dir.mkdir build_folder
        end
        html[:files].each_value do |path|
            FileUtils.cp(path,"#{Dir.pwd}/#{build_folder}")
        end
    end
end
