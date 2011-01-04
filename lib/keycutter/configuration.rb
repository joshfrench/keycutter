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

    File.open(credentials_path, 'w') do |f|
      f.write keys.to_yaml
    end

    @api_keys = keys
  end

  def load_api_keys
    @api_keys = File.exists?(credentials_path) ? load_file(credentials_path) : @hash
    if @api_keys.key?(:rubygems_api_key) and not @api_keys.key?(:rubygems) then
      @api_keys[:rubygems] = @api_keys.delete(:rubygems_api_key)
    end
    @api_keys
  end
end
