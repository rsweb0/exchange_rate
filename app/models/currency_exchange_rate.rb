# frozen_string_literal: true

class CurrencyExchangeRate < ApplicationRecord

  validates :base_currency, presence: true
  validates :target_currency, presence: true
  validates :rate, presence: true
  validates :date, presence: true

end
