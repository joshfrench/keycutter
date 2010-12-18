require 'rubygems/config_file'

class Gem::ConfigFile
  def rubygems_accounts
    @rubygems_accounts ||= load_rubygems_accounts
  end

  def rubygems_accounts=(hash)
    config = load_file(credentials_path).merge(:rubygems_accounts => hash)

    dirname = File.dirname(credentials_path)
    Dir.mkdir(dirname) unless File.exists?(dirname)

    require 'yaml'

    File.open(credentials_path, 'w') do |f|
      f.write config.to_yaml
    end

    @rubygems_accounts = hash
  end

  def load_rubygems_accounts
    credentials_hash = File.exists?(credentials_path) ? load_file(credentials_path) : @hash
    credentials_hash[:rubygems_accounts] || {}
  end
  private :load_rubygems_accounts
end
