require 'rails_helper'

RSpec.describe CurrencyExchangePair, type: :model do
  it do
    should validate_inclusion_of(:base_currency)
      .in_array(Constants::SUPPORTED_CURRENCIES)
      .with_message('Currency is not valid')
  end

  it do
    should validate_inclusion_of(:target_currency)
      .in_array(Constants::SUPPORTED_CURRENCIES)
      .with_message('Currency is not valid')
  end

  it do
    should validate_numericality_of(:number_of_weeks)
      .is_less_than_or_equal_to(52)

    should validate_numericality_of(:number_of_weeks)
      .is_greater_than(0)
  end

  it { should validate_presence_of(:amount) }
end
