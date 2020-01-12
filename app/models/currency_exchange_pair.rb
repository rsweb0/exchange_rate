class CurrencyExchangePair < ApplicationRecord
  validates :number_of_weeks, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 52,
                                                              greater_than: 0 }
  validates :amount, presence: true
  validates_inclusion_of :base_currency, in: Constants::SUPPORTED_CURRENCIES,
                                         allow_nil: false, message: 'Currency is not valid'

  validates_inclusion_of :target_currency, in: Constants::SUPPORTED_CURRENCIES,
                                           allow_nil: false, message: 'Currency is not valid'
end
