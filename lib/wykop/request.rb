require 'rest-client'

module Wykop
  class Request
    def initialize(client)
      @client = client
    end

    def call(resource:, post_params: {}, method_params: {}, with_user_key: true)
      url_builder = Wykop::UrlBuilder.new(app_key: @client.app_key, app_secret: @client.app_secret)
      user_key = with_user_key ? { userkey: @client.userkey } : nil

      url = url_builder.build_url(resource: resource, api_params: user_key, method_params: method_params)
      md5_value = url_builder.build_md5_signature(url: url, post_params: post_params)

      execute md5: md5_value, url: url, post_params: post_params
    end

    private

    def execute(url:, md5:, post_params: nil)
      method = post_params.empty? ? :get : :post

      response = JSON.parse RestClient::Request.execute method: method, url: url, payload: post_params, headers: { apisign: md5 }

      if response['error']
        raise response['error']
      end

      response
    end
  end
end
