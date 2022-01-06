module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { errors: e.message }, status: :not_found
    end

    rescue_from ActionController::BadRequest do |e|
      render json: { errors: JSON.parse(e.message) }, status: :bad_request
    end
  end
end
