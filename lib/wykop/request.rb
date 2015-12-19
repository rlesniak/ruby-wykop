require 'rest-client'

module Wykop
  class Request
    def initialize(client)
      @client = client
    end

    def call(resource:, post_params: {}, method_params: {}, with_user_key: true)
      user_key = with_user_key ? { userkey: @client.user_data['userkey'] } : nil

      url = Wykop::Helpers.build_url(resource: resource, api_params: user_key, method_params: method_params)
      md5_value = Wykop::Helpers.build_md5_signature(url: url, post_params: post_params)

      execute md5: md5_value, url: url, post_params: post_params
    end

    def execute(url:, md5:, post_params: nil)
      RestClient::Request.execute method: :post, url: url, payload: post_params, headers: { apisign: md5 }
    end

  end
end
