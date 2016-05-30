require 'wykop/railtie' if defined?(Rails)

require 'wykop/version'
require 'wykop/configuration'
require 'wykop/url_builder'
require 'wykop/client'
require 'wykop/user'
require 'wykop/request'

module Wykop
  class << self
    attr_writer :configuration
    attr_writer :logger

    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.progname = self.name
      end
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
