module Wykop
  class Configuration
    attr_accessor :api_url, :app_key, :app_secret

    def initialize
      @api_url = 'http://a.wykop.pl/'
    end
  end
end
