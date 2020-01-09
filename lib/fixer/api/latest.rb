# frozen_string_literal: true

module Api
  module Latest
    # Depending on your subscription plan,
    # the API's latest endpoint will return real-time exchange rate data
    # updated every 60 minutes, every 10 minutes or every 60 seconds.
    def latest
      get('latest')
    end
  end
end
