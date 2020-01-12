class CreateCurrencyExchangePairs < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_exchange_pairs do |t|
      t.string :base_currency
      t.string :target_currency
      t.integer :number_of_weeks

      t.timestamps
    end
  end
end
