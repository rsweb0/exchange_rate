# frozen_string_literal: true

namespace :feed do
  desc 'Import last 1year currency_exchange_rates from fixer.io'
  task import_fixer_records: :environment do
    client = Fixer::Client.new
    existing_dates = CurrencyExchangeRate
                     .where(date: [1.years.ago.to_date..Date.today])
                     .distinct.pluck(:date)

    ((1.years.ago.to_date..Date.today).to_a - existing_dates).each do |date|
      data = client.historical(date.strftime('%Y-%m-%d'))
      bulk_data = []
      date = data['date'].to_date
      data['rates'].each do |cur, rate|
        bulk_data << { date: date, base_currency: 'EUR', target_currency: cur, rate: rate }
      end
      CurrencyExchangeRate.create(bulk_data)
    end
  end
end
