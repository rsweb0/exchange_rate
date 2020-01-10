FactoryBot.define do
  factory :currency_exchange_rate do
    base_currency { 'EUR' }
    target_currency { 'USA' }
    rate { 1.5234 }
    date { Date.today }
  end
end
