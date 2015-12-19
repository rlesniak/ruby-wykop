require 'wykop/railtie' if defined?(Rails)

require 'wykop/version'
require 'wykop/configuration'
require 'wykop/helpers'
require 'wykop/client'
require 'wykop/user'
require 'wykop/request'

module Wykop
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
