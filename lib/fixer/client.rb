# frozen_string_literal: true

module Fixer
  class Client < Request
    BASE_URL = 'http://data.fixer.io/api'
    attr_accessor :api_key
    include Api::Latest
    include Api::HistoricalRates

    def initialize(api_key = nil)
      @api_key = api_key || ENV['FIXER_API_KEY']
    end

    private

    def request_url(path)
      "#{BASE_URL}/#{path}?#{query_parameters}"
    end

    def query_parameters
      "access_key=#{api_key}&symbols=#{Constants::SUPPORTED_CURRENCIES.join(',')}"
    end
  end
end
