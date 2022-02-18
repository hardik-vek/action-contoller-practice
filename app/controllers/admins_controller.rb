class AdminsController < ApplicationController
  http_basic_authenticate_with name: "humbaba", password: "sbdhbf555"

  USERS = { "lifo" => "world" }

  before_action :authenticate

  private
    def authenticate
      authenticate_or_request_with_http_digest do |username|
        USERS[username]
      end
    end
end
