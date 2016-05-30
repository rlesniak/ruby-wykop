module Wykop
  class User
    def initialize(client)
      @client = client
    end

    def favorites
      @client.request.call(resource: 'user/favorites')
    end

    def observed
      @client.request.call(resource: 'user/observed')
    end

    def tags
      @client.request.call(resource: 'user/tags')
    end

    def plus(link_id, comment_id)
      params = { param1: link_id, param2: comment_id }

      @client.request.call(resource: 'comment/plus', method_params: params)
    end
  end
end
