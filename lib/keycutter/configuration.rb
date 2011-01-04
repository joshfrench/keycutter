require 'rubygems/config_file'

class Gem::ConfigFile
  def api_keys
    @api_keys || load_api_keys
  end

  def api_keys=(accounts)
    config = load_file(credentials_path).merge(:api_keys => accounts)

    dirname = File.dirname(credentials_path)
    Dir.mkdir(dirname) unless File.exists?(dirname)

    require 'yaml'

    File.open(credentials_path, 'w') do |f|
      f.write config.to_yaml
    end

    @api_keys = accounts
  end

  def load_api_keys
    credentials_hash = File.exists?(credentials_path) ? load_file(credentials_path) : @hash
    @api_keys = credentials_hash[:api_keys] || {}
  end
end
