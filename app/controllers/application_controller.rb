class ApplicationController < ActionController::API
  def render_invalid_record(errors)
    errors = errors.map { |field, message| { field: field, message: message } }
    render json: errors.to_json, status: 422
  end

  def authenticate!
    is_valid = ::AuthenticateRequest.call(request.headers).result

    render json: { error: 'Not Authorized' }, status: 401 unless is_valid
  end
end
