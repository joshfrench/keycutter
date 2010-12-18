require File.dirname(__FILE__) + '/spec_helper.rb'

describe Gem::ConfigFile do
  before do
    @credentials = File.dirname(__FILE__) + '/../test_credentials'
    @config = Gem::ConfigFile.new([])
    @config.stub(:credentials_path) { @credentials }
  end

  describe "#rubygems_accounts" do
    it "should load from credentials file" do
      credentials = {:rubygems_accounts => {'personal' => '1'*32, 'work' => '2'*32}}
      File.open(@credentials, 'w') { |f| f.write credentials.to_yaml }
      @config.rubygems_accounts.should == credentials[:rubygems_accounts] 
    end
  end

  describe "#rubygems_accounts=" do
    it "should write to credentials file" do
      File.open(@credentials, 'w') { |f| f.write '' }
      accounts = {'personal' => '1'*32, 'work' => '2'*32}
      @config.rubygems_accounts = accounts

      File.read(@credentials).should == {:rubygems_accounts => accounts}.to_yaml
    end

    it "should preserve existing credentials" do
      api_key = {:rubygems_api_key => '0'*32}
      File.open(@credentials, 'w') { |f| f.write api_key.to_yaml }

      accounts = {'personal' => '1'*32, 'work' => '2'*32}
      @config.rubygems_accounts = accounts

      credentials = YAML.load_file(@credentials)
      credentials[:rubygems_api_key].should == '0'*32
    end
  end
end
