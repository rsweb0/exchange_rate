require 'rails_helper'

RSpec.describe CurrencyExchangePairDecorator do
  let(:object) do
    FactoryBot.create(:currency_exchange_pair, base_currency: 'EUR',
                                               target_currency: 'USD', number_of_weeks: 1)
  end

  before do
    @cur_exchange = FactoryBot.create(:currency_exchange_rate, date: Date.today, rate: 1.56)
    @exchange_one = FactoryBot.create(:currency_exchange_rate, date: 1.days.ago.to_date, rate: 1.2)
  end
  it 'currency_exchange_pair should respond to decorate' do
    expect(object.respond_to?(:decorate)).to eq true
  end

  it 'should return historic data when base_currency is EUR' do
    expect(object.decorate.historic_data.present?).to eq true
    expect(object.decorate.historic_data).to eq([[@exchange_one.date, @exchange_one.rate],
                                                 [@cur_exchange.date, @cur_exchange.rate]])
  end

  it 'should return historic data when base_currency is not EUR' do
    FactoryBot.create(:currency_exchange_rate, target_currency: 'INR', date: Date.today, rate: 90)
    FactoryBot.create(:currency_exchange_rate, target_currency: 'INR', date: 1.days.ago.to_date, rate: 91)
    FactoryBot.create(:currency_exchange_rate, target_currency: 'CAD', date: Date.today, rate: 1.5)
    FactoryBot.create(:currency_exchange_rate, target_currency: 'CAD', date: 1.days.ago.to_date, rate: 1.4)
    obj = FactoryBot.create(:currency_exchange_pair, base_currency: 'CAD', target_currency: 'INR', number_of_weeks: 1)
    expect(obj.decorate.historic_data.present?).to eq true
    expect(obj.decorate.historic_data).to eq([[1.days.ago.to_date, 65.0], [Date.today, 60.0]])
  end

  it 'should return current_rate' do
    expect(object.decorate.current_rate).to eq @cur_exchange.rate
  end

  it 'should return minmax currency rate' do
    expect(object.decorate.minmax_rate).to eq [1.2, 1.56]
  end

  it 'should return minmax currency exchange date' do
    expect(object.decorate.minmax_date).to eq [1.days.ago.to_date, Date.today]
  end
end
