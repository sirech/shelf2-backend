class ApplicationController < ActionController::API
  def render_invalid_record(errors)
    errors = errors.map { |field, message| { field:, message: } }
    render json: errors.to_json, status: :unprocessable_entity
  end

  def authenticate!
    is_valid = ::AuthenticateRequest.call(request.headers).result

    render json: { error: 'Not Authorized' }, status: :unauthorized unless is_valid
  end
end
