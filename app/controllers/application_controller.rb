class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_internal_error
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  # rescue_from ActionController::RoutingError, with: :render_not_found

  private

  def render_not_found
    redirect_to errors_not_found_path
  end

  def render_internal_error
    redirect_to errors_internal_server_error_path
  end
end
