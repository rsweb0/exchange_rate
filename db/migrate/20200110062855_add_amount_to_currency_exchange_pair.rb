class AddAmountToCurrencyExchangePair < ActiveRecord::Migration[6.0]
  def change
    add_column :currency_exchange_pairs, :amount, :integer
  end
end
