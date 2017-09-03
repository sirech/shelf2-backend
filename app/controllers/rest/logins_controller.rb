module Rest
  class LoginsController < ApplicationController
    def create
      command = ::AuthenticateUser.call(params[:user], params[:password])

      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end
