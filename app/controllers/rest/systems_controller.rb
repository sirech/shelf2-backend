module Rest
  class SystemsController < ApplicationController
    def healthcheck
      Book.last&.title
      render :ok
    end
  end
end
