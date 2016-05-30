require 'digest'
require 'base64'

module Wykop
  class UrlBuilder
    def initialize(app_key:, app_secret:)
      @app_key, @app_secret = app_key, app_secret
    end

    def build_url(resource:, api_params:, method_params:{})
      api_params = parametrize_hash api_params
      method_params = parametrize_hash method_params, '/'

      "#{Wykop.configuration.api_url + resource}/#{method_params}/appkey/#{@app_key}/#{api_params}"
    end

    def connect_user_url(url = '')
      redirect_url = Base64.urlsafe_encode64(url)
      secure       = Digest::MD5.hexdigest(@app_secret + url)
      api_params   = { secure: secure }

      api_params.merge(redirect: redirect_url) unless url.empty?

      build_url(resource: 'user/connect', api_params: api_params)
    end

    def get_login_checksum(login, token)
      Digest::MD5.hexdigest(@app_secret + @app_key + login + token)
    end

    def build_md5_signature(url:, post_params:)
      Digest::MD5.hexdigest(@app_secret + url + implode_post_params(post_params))
    end

    private

    def parametrize_hash(hash, divider = ',')
      hash.map { |k, v| "#{k}#{divider}#{v}" }.join divider if hash
    end

    def implode_post_params(params)
      params.sort.map{ |name, val| val }.join ','
    end
  end
end
