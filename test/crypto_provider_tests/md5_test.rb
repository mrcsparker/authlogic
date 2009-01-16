require File.dirname(__FILE__) + '/../test_helper.rb'

module CryptoProviderTests
  class Md5Test < ActiveSupport::TestCase
    def test_encrypt
      assert Authlogic::CryptoProviders::Md5.encrypt("mypass")
    end
    
    def test_matches
      hash = Authlogic::CryptoProviders::Md5.encrypt("mypass")
      assert Authlogic::CryptoProviders::Md5.matches?(hash, "mypass")
    end
  end
end
