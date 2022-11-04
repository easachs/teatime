# frozen_string_literal: true

module Api
  module V1
    class TeasController < ApplicationController
      def index
        render json: TeaSerializer.all_teas
      end
    end
  end
end
