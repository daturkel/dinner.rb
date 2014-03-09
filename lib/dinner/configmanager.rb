# This class is for creating/accessing a config file with options for Dinner
class ConfigManager

  # The defaults for the config file
  @@default = {
    :build_folder => "build"
  }

  # A getter method for the config defaults
  def self.default
    @@default
  end

end

