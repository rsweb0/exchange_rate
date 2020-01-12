class CurrencyExchangePairDecorator < Draper::Decorator
  delegate_all

  def historic_data
    @historic_data ||= conversion_needed? ? process_exchange_rates : fetch_exchange_rates(target_currency)
  end

  def minmax_rate
    historic_data.map { |d| d[1] }.minmax
  end

  def minmax_date
    historic_data.map { |d| d[0] }.minmax
  end

  def current_rate
    @current_rate ||= CurrencyExchangeRate.where(date: Date.today, target_currency: target_currency)
                                          .pluck(:rate).first || 0
  end

  private

  def fetch_exchange_rates(currency)
    CurrencyExchangeRate.between_dates(date_range).by_target_currency(currency).pluck(:date, :rate)
  end

  def date_range
    (Date.today - (number_of_weeks - 1).weeks).beginning_of_week..Date.today
  end

  def process_exchange_rates
    target_rates = fetch_exchange_rates(target_currency)
    base_rates = fetch_exchange_rates(base_currency)
    target_rates.each_with_index.map do |tr, index|
      [tr[0], calculate_exchange_rate(base_rates[index][1], tr[1])]
    end
  end

  def conversion_needed?
    base_currency != Constants::BASE_CURRENCY
  end

  # find exchange value if base_currency is not EUR
  # it will return approx value
  def calculate_exchange_rate(base_rate, target_rate)
    (target_rate / base_rate)
  end
end
