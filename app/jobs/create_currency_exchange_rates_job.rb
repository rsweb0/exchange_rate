# frozen_string_literal: true

class CreateCurrencyExchangeRatesJob < ApplicationJob
  queue_as :default

  def perform(day)
    date = Date.parse(day)
    return if date != Date.today && CurrencyExchangeRate.exists_for_date?(date)

    Rails.logger.info("Create or Update exchange rates for #{date}")
    fetch_and_save_historical_data(date)
    Rails.logger.info("Successfully created/updated exchange rates for #{date}")
  rescue Date::Error
    Rails.logger.info("Failed to create exchanges rates: INVALID DATE #{day}")
  end

  def fetch_and_save_historical_data(date)
    data = CurrencyExchange.new.client.historical(date.strftime('%Y-%m-%d'))
    date = data['date'].to_date
    currency_exchange_rate_records = []
    data['rates'].each do |target_currency, rate|
      record = CurrencyExchangeRate.find_or_initialize_by(date: date, base_currency: Constants::BASE_CURRENCY,
                                                          target_currency: target_currency)
      record.rate = rate
      currency_exchange_rate_records << record
    end

    ActiveRecord::Base.transaction do
      currency_exchange_rate_records.map(&:save!)
    end
  end
end
