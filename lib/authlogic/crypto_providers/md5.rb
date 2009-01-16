require "digest/md5"

module Authlogic
  # = Crypto Providers
  #
  # The acts_as_authentic method allows you to pass a :crypto_provider option. This allows you to use any type of encryption you like.
  # Just create a class with a class level encrypt and matches? method. See example below.
  #
  # === Example
  #
  #   class MyAwesomeEncryptionMethod
  #     def self.encrypt(*tokens)
  #       # the tokens passed will be an array of objects, what type of object is irrelevant,
  #       # just do what you need to do with them and return a single encrypted string.
  #       # for example, you will most likely join all of the objects into a single string and then encrypt that string
  #     end
  #
  #     def self.matches?(crypted, *tokens)
  #       # return true if the crypted string matches the tokens.
  #       # depending on your algorithm you might decrypt the string then compare it to the token, or you might
  #       # encrypt the tokens and make sure it matches the crypted string, its up to you
  #     end
  #   end
  module CryptoProviders
    # = md5
    #
    # Uses the md5 hash algorithm to encrypt passwords.
    class Md5

      def self.encrypt(*tokens)
        Digest::MD5.hexdigest(tokens.join.to_s).to_s
      end

      def self.matches?(crypted, tokens)
        encrypt(*tokens) == crypted
      end
    end
  end
end
