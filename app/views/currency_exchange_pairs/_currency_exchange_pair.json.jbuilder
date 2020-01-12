json.extract! currency_exchange_pair, :id, :base_currency, :target_currency, :number_of_weeks, :created_at, :updated_at
json.url currency_exchange_pair_url(currency_exchange_pair, format: :json)
