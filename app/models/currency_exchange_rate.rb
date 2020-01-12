# frozen_string_literal: true

class CurrencyExchangeRate < ApplicationRecord
  validates :rate, presence: true
  validates :date, presence: true

  validates_inclusion_of :base_currency, in: Constants::SUPPORTED_CURRENCIES,
                                         allow_nil: false

  validates_inclusion_of :target_currency, in: Constants::SUPPORTED_CURRENCIES,
                                           allow_nil: false

  scope :between_dates, ->(date_range) { where(date: date_range) }
  scope :by_target_currency, ->(currency) { where(target_currency: currency) }

  def self.exists_for_date?(date)
    CurrencyExchangeRate.find_by(date: date).present?
  end
end
