FactoryBot.define do
  factory :currency_exchange_pair do
    base_currency { 'EUR' }
    target_currency { 'USD' }
    amount { 10 }
    number_of_weeks { 5 }
  end
end
