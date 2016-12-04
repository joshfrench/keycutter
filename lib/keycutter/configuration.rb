require 'rubygems/config_file'

class Gem::ConfigFile
  def api_keys
    @api_keys || load_api_keys
  end

  def api_keys=(keys)
    keys.merge!(:rubygems_api_key => @rubygems_api_key) if defined? @rubygems_api_key

    dirname = File.dirname(credentials_path)
    Dir.mkdir(dirname) unless File.exists?(dirname)

    require 'yaml'

    File.open(credentials_path, 'w', 0600) do |f|
      f.write keys.to_yaml
    end

    @api_keys = keys
  end

  def load_api_keys
    @api_keys = File.exists?(credentials_path) ? load_file(credentials_path) : {}
    if @api_keys.key?(:rubygems_api_key)
      @rubygems_api_key = @api_keys.delete(:rubygems_api_key)
      @api_keys[:rubygems] = @rubygems_api_key unless @api_keys.key?(:rubygems)
    end
    @api_keys
  end
end
