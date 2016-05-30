module Wykop
  class Configuration
    attr_accessor :api_url

    def initialize
      @api_url = 'http://a.wykop.pl/'
    end
  end
end
