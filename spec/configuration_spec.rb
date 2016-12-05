require File.dirname(__FILE__) + '/spec_helper.rb'

describe Gem::ConfigFile do
  before do
    @credentials = File.dirname(__FILE__) + '/../test_credentials'
    @config = Gem::ConfigFile.new([])
    allow(@config).to receive(:credentials_path) { @credentials }
  end

  describe "#api_keys" do
    it "should load from credentials file" do
      credentials = {:personal => '1'*32, :work => '2'*32}
      File.open(@credentials, 'w') { |f| f.write credentials.to_yaml }
      expect(@config.api_keys).to eq(credentials)
    end

    it "should add existing rubygems key to the hash" do
      credentials = {:rubygems_api_key => '0'*32}
      File.open(@credentials, 'w') { |f| f.write credentials.to_yaml }
      expect(@config.api_keys).to eq({:rubygems => '0'*32})
    end
  end

  describe "#api_keys=" do
    it "should write to credentials file" do
      File.open(@credentials, 'w') { |f| f.write '' }
      accounts = {:personal => '1'*32, :work => '2'*32}
      @config.api_keys = accounts

      expect(File.read(@credentials)).to eq(accounts.to_yaml)
    end

    it "should preserve existing credentials" do
      @config.rubygems_api_key = '0'*32
      @config.api_keys = {:personal => '1'*32, :work => '2'*32}

      credentials = YAML.load_file(@credentials)
      expect(credentials[:rubygems_api_key]).to eq('0'*32)
    end
  end
end
