class AddIndexToCurrencyExchangeRates < ActiveRecord::Migration[6.0]
  def change
    add_index :currency_exchange_rates, :date
    add_index :currency_exchange_rates, :target_currency
    add_index :currency_exchange_rates, %i[date base_currency target_currency],
              unique: true, name: 'index_exchange_rates_on_date_and_base_cur_and_target_cur'
  end
end
