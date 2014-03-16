# This class is for creating/accessing a config file with options for Dinner
class ConfigManager

  # The defaults for the config file
  DEFAULT = {
    :build_folder => "build",
    :copy_formats => ["js","css"]
  }

  @@config = {}

  # Access the configuration hash
  def self.config
    @@config
  end

  # A getter method for the config defaults
  def self.default
    DEFAULT
  end

  # Create a config file if there isn't yet one
  def self.init_config
    if File.exists?("#{Dir.pwd}/dinconfig.yaml")
      self.load_config("#{Dir.pwd}/dinconfig.yaml")
    else
      File.open("#{Dir.pwd}/dinconfig.yaml","w+") do |file|
        file.puts(DEFAULT.to_yaml)
      end
      self.load_config("#{Dir.pwd}/dinconfig.yaml")
    end
  end

  # Load the current config file
  def self.load_config(file_path)
    @@config = YAML.load(File.read(file_path))
  end
end

