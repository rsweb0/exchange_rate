# frozen_string_literal: true

class CreateCurrencyExchangeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_exchange_rates do |t|
      t.string :target_currency
      t.date :date
      t.decimal :rate

      t.timestamps
    end
  end
end
