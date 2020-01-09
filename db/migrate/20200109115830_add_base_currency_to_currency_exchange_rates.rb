class AddBaseCurrencyToCurrencyExchangeRates < ActiveRecord::Migration[6.0]
  def change
    add_column :currency_exchange_rates, :base_currency, :string
  end
end
