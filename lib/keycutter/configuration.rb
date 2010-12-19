require 'rubygems/config_file'

class Gem::ConfigFile
  def rubygems_accounts
    @rubygems_accounts || load_rubygems_accounts
  end

  def rubygems_accounts=(accounts)
    config = load_file(credentials_path).merge(:rubygems_accounts => accounts)

    dirname = File.dirname(credentials_path)
    Dir.mkdir(dirname) unless File.exists?(dirname)

    require 'yaml'

    File.open(credentials_path, 'w') do |f|
      f.write config.to_yaml
    end

    @rubygems_accounts = accounts
  end

  def load_rubygems_accounts
    credentials_hash = File.exists?(credentials_path) ? load_file(credentials_path) : @hash
    @rubygems_accounts = credentials_hash[:rubygems_accounts] || {}
  end
end
