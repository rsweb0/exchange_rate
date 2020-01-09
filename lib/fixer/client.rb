# frozen_string_literal: true

module Fixer
  class Client < Request
    attr_accessor :api_key, :base_url
    include Api::Latest
    include Api::HistoricalRates

    def initialize
      @api_key = ENV['FIXER_API_KEY']
      @base_url =  ENV['FIXER_BASE_URL']
    end

    private

    def request_url(path)
      "#{base_url}/#{path}?#{query_parameters}"
    end

    def query_parameters
      "access_key=#{api_key}"
    end
  end
end
