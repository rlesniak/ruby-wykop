require 'digest'
require 'base64'

module Wykop
  class Helpers
    class << self
      def build_url(resource:, api_params:, method_params:{})
        app_key = Wykop.configuration.app_key

        api_params = parametrize_hash api_params
        method_params = parametrize_hash method_params, '/'

        "#{Wykop.configuration.api_url + resource}/#{method_params}/appkey/#{app_key}/#{api_params}"
      end

      def connect_user_url(url)
        redirect_url = Base64.urlsafe_encode64(url)
        secure = Digest::MD5.hexdigest(Wykop.configuration.app_secret + url)

        build_url(resource: 'user/connect', api_params: { redirect: redirect_url, secure: secure })
      end

      def parametrize_hash(hash, divider = ',')
        hash.map { |k, v| "#{k}#{divider}#{v}" }.join divider if hash
      end

      def get_login_checksum(login, token)
        Digest::MD5.hexdigest(Wykop.configuration.app_secret + Wykop.configuration.app_key + login + token)
      end

      def build_md5_signature(url:, post_params:)
        Digest::MD5.hexdigest(Wykop.configuration.app_secret + url + implode_post_params(post_params))
      end

      def implode_post_params(params)
        params.sort.map{ |name, val| val }.join ','
      end
    end
  end
end
