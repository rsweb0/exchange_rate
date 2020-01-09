# frozen_string_literal: true

module Api
  module HistoricalRates
    # Historical rates are available for most currencies
    # all the way back to the year of 1999.
    # You can query the Fixer API for historical rates by appending
    # a date (format YYYY-MM-DD) to the base URL.
    def historical(date)
      get(date.to_s)
    end
  end
end
