module Wykop
  class Client
    attr_reader :app_key, :app_secret, :request, :userkey

    def initialize(app_key:, app_secret:)
      @app_key, @app_secret = app_key, app_secret

      @request = Request.new(self)
    end

    def login(username:, accountkey:)
      params = { login: username, accountkey: accountkey }

      response = @request.call(resource: 'user/login', with_user_key: false, post_params: params)

      @userkey = response['userkey']
    end

    def user
      @user ||= User.new(self)
    end
  end
end
