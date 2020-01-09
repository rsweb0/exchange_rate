# frozen_string_literal: true

module Fixer
  class Error < ::StandardError
    class << self
      def on_fail(response)
        raise Fixer::Error::BadRequest.new(response.inspect) # rubocop:disable RaiseArgs
      end

      def on_complete(response)
        raise Fixer::Error::Unknown.new(response.inspect) # rubocop:disable RaiseArgs
      end
    end

    ClientError = Class.new(self)

    # Raised when Fixer returns the success false
    BadRequest = Class.new(ClientError)

    # Raised when Fixer not returns 200 response
    Unknown = Class.new(ClientError)
  end
end
