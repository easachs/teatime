# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def request_params
    JSON.parse(request.raw_post, symbolize_names: true) unless ['', nil].include?(request.raw_post)
  end
end
