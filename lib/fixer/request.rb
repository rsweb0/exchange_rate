# frozen_string_literal: true

module Fixer
  class Request
    def get(url)
      resp = JSON.parse(RestClient.get(request_url(url)))
      Fixer::Error.on_fail(resp) unless resp['success']
      resp
    rescue StandardError => e
      raise e if e.is_a?(Fixer::Error::ClientError)

      Fixer::Error.on_complete(e)
    end
  end
end
