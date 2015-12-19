module Wykop
  class Client
    attr_reader :request, :user_data

    def initialize(login, accountkey)
      @request = Request.new(self)
      @user_data = user_basic(login, accountkey)
    end

    def user_basic(login, accountkey)
      params = { login: login, accountkey: accountkey }

      JSON.parse @request.call(resource: 'user/login', with_user_key: false, post_params: params)
    end

    def user
      @user ||= User.new(self)
    end
  end
end
