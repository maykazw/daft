class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do
    render json: {status: "has_errors", status_no: 422, response: "Parameter missing"}, status: 400
  end
end
